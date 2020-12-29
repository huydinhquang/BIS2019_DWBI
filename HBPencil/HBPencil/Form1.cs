using System;
using System.Collections.Generic;
using System.Threading;
using System.Windows.Forms;

namespace HBPencil
{
    public partial class Form1 : Form
    {
        List<DistrictWard> listDistrictWard = new List<DistrictWard>();
        List<District> listDistrict = new List<District>();
        PrepareData prepareData = new PrepareData();
        string Input = string.Empty;
        public Thread thread;

        public Form1()
        {
            InitializeComponent();
            prepareData.AddWardFullName();
            prepareData.AddDistrictFullName();
            listDistrictWard = prepareData.AddDistrictWard();
            listDistrict = prepareData.AddDistrict();
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            rtbOutput.Text = string.Empty;
            Input = rtbInput.Text;

            // Creating thread 
            thread = new Thread(new ThreadStart(RunWithThread))
            {
                IsBackground = true
            };
            thread.Start();
            //MessageBox.Show("Done", "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public void RunWithThread()
        {
            var listInput = Input.Split('\n');
            foreach (var item in listInput)
            {
                // For address which has separator = ","
                // Ex: 436/59/53 CMT8, P11, Q3, Hồ Chí Minh
                var listItem = item.Split(',');
                // Check if address has only 1 separator = ","
                // Ex: 1/49 Trần Văn Đang, P9 Q3 TPHCM ==> Should split by " "
                if (listItem.Length == 2)
                {
                    listItem = item.Split(' ');
                }

                var result = MatchDistrictWard(listItem);

                // Ex: 14/4 an bình phường 5 quận 5 tphcm ==> Should check by contains
                if (result.WardId == 0 || result.DistrictId == 0)
                {
                    var districtWard = ContainDistrictWard(item);
                    var result_Ward = listDistrictWard.Find(x => x.Ward.Equals(districtWard.Ward) && x.District.Equals(districtWard.District));
                    var result_District = listDistrict.Find(x => x.DistrictName.Equals(districtWard.District));
                    if (result_Ward != null && result_District != null)
                    {
                        result.WardId = result_Ward.Id;
                        result.DistrictId = result_District.Id;
                    }
                }

                var output = $"{item} ### {result.WardId} ### {result.DistrictId}{Environment.NewLine}";
                AppendTextBox(output);
            }
        }

        public void AppendTextBox(string value)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(AppendTextBox), new object[] { value });
                return;
            }
            rtbOutput.Text += value;
        }

        private Result MatchDistrictWard(string[] rawData)
        {
            var result = new Result();

            // Loop for item in list DistrictWard
            foreach (var p in listDistrictWard)
            {
                // p = "Id = 68; District = Quận 6; Ward = Phường 3"
                // Match Ward first (Ex: Phường 3)
                var isFirstMatched = false;
                // Then, match District (Ex: Quận 6)
                var isLastMatched = false;
                // Loop for item separate by "," in "436/59/53 CMT8, P11, Q3, Hồ Chí Minh" or " " in "1/49 Trần Văn Đang, P9 Q3 TPHCM"
                foreach (var item in rawData)
                {
                    // Remove unnecessary characters
                    var itemTrim = item.TrimStart().TrimEnd().Replace(",", string.Empty);
                    // Get full Ward name (P15 --> Phường 15)
                    itemTrim = prepareData.GetWardFull(itemTrim);
                    if (itemTrim.EndsWith(p.Ward, StringComparison.OrdinalIgnoreCase) || p.Ward.EndsWith(itemTrim, StringComparison.OrdinalIgnoreCase))
                    {
                        isFirstMatched = true;
                        continue;
                    }
                    if (isFirstMatched)
                    {
                        // Get full District name (Q6 --> Quận 6)
                        itemTrim = prepareData.GetDistrictFull(itemTrim);
                        if (itemTrim.EndsWith(p.District, StringComparison.OrdinalIgnoreCase) || p.District.EndsWith(itemTrim, StringComparison.OrdinalIgnoreCase))
                        {
                            foreach (var d in listDistrict)
                            {
                                if (itemTrim.EndsWith(d.DistrictName, StringComparison.OrdinalIgnoreCase) || d.DistrictName.EndsWith(itemTrim, StringComparison.OrdinalIgnoreCase))
                                {
                                    result.WardId = p.Id;
                                    result.DistrictId = d.Id;
                                    isLastMatched = true;
                                    break;
                                }
                            }
                            if (isLastMatched) break;
                        }
                    }
                }
                if (isLastMatched) break;
            }
            return result;
        }

        private DistrictWard ContainDistrictWard(string address)
        {
            var districtWard = new DistrictWard();

            foreach (var key in prepareData.DicWardFullName.Keys)
            {
                if (address.ToLower().Contains(key.ToLower()))
                {
                    districtWard.Ward = prepareData.DicWardFullName[key];
                }
            }

            foreach (var key in prepareData.DicDistrictFullName.Keys)
            {
                if (address.ToLower().Contains(key.ToLower()))
                {
                    districtWard.District = prepareData.DicDistrictFullName[key];
                }
            }

            return districtWard;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            thread.Abort();
        }
    }
}
