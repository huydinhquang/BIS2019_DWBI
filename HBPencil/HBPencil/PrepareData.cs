using System;
using System.Collections.Generic;
using System.Configuration;

namespace HBPencil
{
    public class PrepareData
    {
        public Dictionary<string, string> DicWardFullName { get; set; }
        public Dictionary<string, string> DicDistrictFullName { get; set; }

        Dictionary<string, string> ListWardFullName = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        Dictionary<string, string> ListDistrictFullName = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

        public List<DistrictWard> AddDistrictWard()
        {
            var listDistrictWard = new List<DistrictWard>();
            var data = ConfigurationManager.AppSettings.Get("DistrictWard");
            var listData = data.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var item in listData)
            {
                var record = item.Split(';');
                if (record.Length <= 1) continue;
                var districtWard = new DistrictWard
                {
                    Id = Convert.ToInt32(record[0].TrimStart().TrimEnd()),
                    District = record[1].ToString(),
                    Ward = record[2].ToString()
                };
                listDistrictWard.Add(districtWard);
            }
            return listDistrictWard;
        }

        public List<District> AddDistrict()
        {
            var listDistrict = new List<District>();
            var data = @"1;Quận 1
                        2;Quận 2
                        3;Quận 3
                        4;Quận 4
                        5;Quận 5
                        6;Quận 6
                        7;Quận 7
                        8;Quận 8
                        9;Quận 9
                        10;Quận 10
                        11;Quận 11
                        12;Quận 12
                        13;Quận Bình Tân
                        14;Quận Bình Thạnh
                        15;Quận Gò Vấp
                        16;Quận Phú Nhuận
                        17;Quận Tân Bình
                        18;Quận Tân Phú
                        19;Quận Thủ Đức
                        20;Huyện Bình Chánh
                        21;Huyện Cần Giờ
                        22;Huyện Củ Chi
                        23;Huyện Hóc Môn
                        24;Huyện Nhà Bè
                        ";
            var listData = data.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var item in listData)
            {
                var record = item.Split(';');
                if (record.Length <= 1) continue;
                var district = new District
                {
                    Id = Convert.ToInt32(record[0].TrimStart().TrimEnd()),
                    DistrictName = record[1].ToString()
                };
                listDistrict.Add(district);
            }
            return listDistrict;
        }

        public void AddWardFullName()
        {
            var data = ConfigurationManager.AppSettings.Get("Ward");
            var listData = data.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var item in listData)
            {
                var record = item.Split(';');
                if (record.Length <= 1) continue;
                ListWardFullName.Add(record[0].ToString(), record[1].ToString());
            }
            DicWardFullName = ListWardFullName;
        }
        public void AddDistrictFullName()
        {
            var data = ConfigurationManager.AppSettings.Get("District");
            var listData = data.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var item in listData)
            {
                var record = item.Split(';');
                if (record.Length <= 1) continue;
                ListDistrictFullName.Add(record[0].ToString(), record[1].ToString());
            }
            DicDistrictFullName = ListDistrictFullName;
        }

        public string GetWardFull(string value)
        {
            var result = string.Empty;
            foreach (var key in ListWardFullName.Keys)
            {
                if (value.ToLower().Contains(key.ToLower()) || key.ToLower().Contains(value.ToLower()))
                {
                    result = ListWardFullName[key];
                    break;
                }
            }
            return result == string.Empty ? value : result;
        }

        public string GetDistrictFull(string value)
        {
            var result = string.Empty;
            foreach (var key in ListDistrictFullName.Keys)
            {
                if (value.ToLower().Contains(key.ToLower()) || key.ToLower().Contains(value.ToLower()))
                {
                    result = ListDistrictFullName[key];
                    break;
                }
            }
            return result == string.Empty ? value : result;
        }
    }
}
