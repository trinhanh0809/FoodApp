CREATE DATABASE hatoyamaRestaurant;
use hatoyamaRestaurant;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    password VARCHAR(255),
    avatar_thumbnail VARCHAR(1000) 
);

CREATE TABLE food (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    price DECIMAL(10, 2) default 0,
    ingredients TEXT,
    description TEXT,
    img_thumbnail VARCHAR(1000),
    total_orders int default 0
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT,
    user_id INT,
    order_datetime DATETIME DEFAULT CURRENT_TIMESTAMP, 
    quantity INT default 1,
    total_price DECIMAL(10, 2) default 0.0,
    FOREIGN KEY (food_id) REFERENCES food(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);



INSERT INTO users (name, phone_number, address, password, avatar_thumbnail) VALUES
    ('Trịnh Đức Anh', 'admin@gmail.com', 'Đại học Mỏ Địa Chất Hà Nội', '12345', 'https://haycafe.vn/wp-content/uploads/2022/03/Hinh-anh-chan-dung-nam-dep.jpg');

INSERT INTO food (name, price, ingredients, description, img_thumbnail) VALUES
('Sushi Sashimi Combo', 350000, 'Cá ngừ, cá hồi, cá da trơn', 'Một combo ngon miệng với các miếng sushi và sashimi hòa quyện, kèm theo wasabi và nước tương.', 'https://images.squarespace-cdn.com/content/v1/51d3a842e4b0d2448ac01e8d/cad0d366-f2a5-4f44-bbac-a081bf3a9e26/DeluxeSushiCombo.jpg'),
('Ramen Deluxe', 120000, 'Mì trứng, thịt lợn, măng cụt', 'Một tô ramen béo ngon với nước dùng đậm đà, thịt lợn mềm mại và mì trứng hoàn hảo.', 'https://www.tablefortwoblog.com/wp-content/uploads/2022/02/beef-ramen-noodle-soup-photo-tablefortwoblog-3-scaled.jpg'),
('Tempura Udon', 95000, 'Mì udon, tôm tempura, rau củ', 'Một tô udon ấm áp được phục vụ với tôm tempura giòn và rau củ đa dạng.', 'https://images.yummy.ph/yummy/uploads/2023/03/tempura-udon-640.jpg'),
('Okonomiyaki', 85000, 'Bột bánh, thịt lợn, bắp cải', 'Một loại bánh xèo Nhật Bản hấp dẫn với bột bánh, thịt lợn và bắp cải, ăn kèm sốt mayonnaise và sốt okonomiyaki.', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Okonomiyaki_001.jpg/1200px-Okonomiyaki_001.jpg'),
('Yakitori', 60000, 'Thịt gà, nước tương, mật ong', 'Những que gà nướng thơm ngon, ướp nướng trong sốt nước tương và mật ong, đậm đà và hấp dẫn.', 'https://d21klxpge3tttg.cloudfront.net/wp-content/uploads/2012/01/spark-grill-yakitori_05.jpg'),
('Chawanmushi', 75000, 'Trứng gà, tôm, gà luộc', 'Một món chawanmushi trứng hấp với các thành phần như trứng gà, tôm và gà luộc, tạo nên hương vị tuyệt vời.', 'https://sudachirecipes.com/wp-content/uploads/2023/01/chawanmushi-sq.jpg'),
('Gyudon', 90000, 'Thịt bò, cebu, hành tây', 'Một tô cơm trộn với thịt bò và hành tây, chấm vào nước sốt đậm đà, thơm ngon.', 'https://www.marionskitchen.com/wp-content/uploads/2022/11/Gyudon-Japanese-Beef-Rice-Bowl-02.jpg'),
('Unagi Don', 160000, 'Cá lóc nước ngọt, cơm trắng', 'Một phần cơm trắng được phục vụ với cá lóc nước ngọt nướng, tạo nên hương vị đặc trưng của ẩm thực Nhật Bản.', 'https://i.redd.it/klz12gptodr71.jpg'),
('Miso Soup', 45000, 'Tảo biển, đậu tofu, nước dùng miso', 'Một tô súp miso truyền thống với tảo biển, đậu tofu và nước dùng miso thơm ngon và dinh dưỡng.', 'https://cdn.media.amplience.net/i/japancentre/recipe%20-2%20-Miso%20soup/Miso-soup?$poi$&w=700&h=410&sm=c&fmt=auto'),
('Soba Noodles with Tempura', 110000, 'Mì soba, tôm tempura, rau củ', 'Mì soba đặc trưng được phục vụ với tôm tempura giòn và rau củ tươi ngon, ăn kèm với nước tương.', 'https://dashilabvn.com/wp-content/uploads/2020/12/SIZE-HINH-WEB-3.png'),
('Takoyaki', 70000, 'Bột chiên, bạch tuộc, sốt mayonnaise', 'Những viên bánh trứng chiên nhỏ với bạch tuộc bên trong, ăn kèm với sốt mayonnaise đặc trưng.', 'https://checkinvietnam.vtc.vn/media/20211206/images/takoyaki_50w.jpg'),
('Yudofu', 85000, 'Đậu hủ, nước dùng kombu, rau củ', 'Một bữa ăn nhẹ với đậu hủ và rau củ nấu trong nước dùng kombu, tạo nên hương vị tinh tế và ngon miệng.', 'https://www.justonecookbook.com/wp-content/uploads/2019/12/Hot-Tofu-1219-I-1.jpg'),
('Nigiri Sushi Set', 300000, 'Cơm sushi, cá hồi, cá ngừ, tôm', 'Bộ sushi gồm cơm sushi với các loại như cá hồi, cá ngừ và tôm, được trang trí mỹ quan và hấp dẫn.', 'https://i.pinimg.com/736x/57/dd/77/57dd770e3b98cff1985ef5fa8227349b.jpg'),
('Kaiseki Ryori', 500000, 'Mút bạch tuộc, thịt bò Wagyu, sò điệp', 'Một bữa tiệc trải nghiệm ẩm thực Nhật Bản cao cấp với các món như mút bạch tuộc, thịt bò Wagyu và sò điệp.', 'https://byfood.b-cdn.net/api/public/assets/9362/content'),
('Chirashi Don', 250000, 'Cơm trắng, hải sản tươi ngon', 'Một phần cơm trắng phủ đầy hải sản tươi ngon như cá hồi, tôm, và sò điệp, tạo nên một bữa trưa hoàn hảo.', 'https://www.justonecookbook.com/wp-content/uploads/2020/04/Quick-Easy-Chirashi-Sushi-4117-I.jpg'),
('Shabu-Shabu', 180000, 'Thịt bò, nấm, rau sống', 'Một phong cách ẩm thực nổi tiếng với thịt bò mỏng, nấm và rau sống được nhúng vào nước dùng nóng sôi.', 'https://sudachirecipes.com/wp-content/uploads/2023/03/shabushabu-sq.jpg'),
('Hōtō', 120000, 'Bánh mì, thịt gà, rau củ', 'Một món ăn phổ biến ở vùng Yamanashi, Hōtō bao gồm bánh mì, thịt gà và rau củ nấu trong nước dùng ngon miệng.', 'https://www.justonecookbook.com/wp-content/uploads/2019/03/Hoto-I-1.jpg'),
('Sukiyaki', 200000, 'Thịt bò, nấm, bún udon', 'Một món sukiyaki truyền thống với thịt bò, nấm, rau và bún udon, nấu trong nồi lớn trên bàn ăn.', 'https://www.uwajimaya.com/wp-content/uploads/2021/02/sukiyaki_hero.jpg'),
('Sake Nigiri', 80000, 'Cơm sushi, cá hồi', 'Nigiri sushi với lớp cá hồi tươi ngon, ăn kèm với một chút wasabi.', 'https://www.allrecipes.com/thmb/fkeqYFLhRaafDi-Dbl8bDPJwrd4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/What-Is-Nigiri-4x3-79ab72ae4148404d91aa430b701373e5.jpg'),
('Tako Sashimi', 120000, 'Bạch tuộc', 'Sashimi làm từ bạch tuộc tươi ngon, cắt thành những lát mỏng hấp dẫn.', 'https://d2j6dbq0eux0bg.cloudfront.net/images/78888263/3215625136.jpg'),
('Ika Teriyaki', 95000, 'Mực, sốt teriyaki', 'Mực được nướng chín tới, phủ lớp sốt teriyaki thơm ngon, ăn kèm cùng cơm trắng.', 'https://tachibana.us/sushi/wp-content/uploads/IKA-TERIYAKI.jpg'),
('Kani Miso Soup', 75000, 'Nước dùng miso, thịt cua', 'Súp miso truyền thống được thêm thịt cua, tạo nên hương vị đặc biệt.', 'https://5002121-s3user.s3.cloudstorage.com.vn/hokkaido-sachi-prod/image/2020/7/24/3/uQW1595559839054.jpeg'),
('Amaebi Nigiri', 120000, 'Cá tôm hùm ngọt', 'Nigiri sushi với cá tôm hùm ngọt, thường được ăn sống.', 'https://olo-images-live.imgix.net/9b/9b2c16475c0e4399b86bf89b640625f6.jpg?auto=format%2Ccompress&q=60&cs=tinysrgb&w=528&h=352&fit=fill&fm=png32&bg=transparent&s=d72b873472614ad7a3e158d87719b8dd'),
('Maguro Poke Bowl', 160000, 'Cơm sushi, cá ngừ, sốt poke', 'Một phần cơm trắng được phục vụ với cá ngừ ăn sống và sốt poke phô mai.', 'https://media-cdn.tripadvisor.com/media/photo-s/17/0d/c1/32/maguro-poke-bowl-tuna.jpg'),
('Anago Nigiri', 100000, 'Cá lươn', 'Nigiri sushi với lớp cá lươn, thường được nướng chín hoặc nướng giữa.', 'https://www.thedailymeal.com/img/gallery/whats-the-difference-between-unagi-and-anago/l-intro-1669753957.jpg'),
('Uni Don', 250000, 'Nội tạng sò điệp, cơm trắng', 'Một phần cơm trắng phủ đầy nội tạng sò điệp (uni), tạo nên hương vị độc đáo và thơm ngon.', 'https://rimage.gnst.jp/livejapan.com/public/article/detail/a/10/00/a1000148/img/en/a1000148_parts_5bb580aeacd9d.jpg?20200610194315&q=80&rw=686&rh=490'),
('Saba Shioyaki', 85000, 'Cá mòi, muối', 'Cá mòi được nướng giòn với lớp muối, tạo ra một món ăn cá hồi khá phổ biến.', 'https://www.justonecookbook.com/wp-content/uploads/2019/02/Saba-Shioyaki-I-1.jpg'),
('Kaisen Don', 300000, 'Cơm sushi, hải sản tươi ngon', 'Một phần cơm trắng phủ đầy các loại hải sản tươi ngon như sò điệp, tôm, cá hồi và nội tạng sò điệp.', 'https://savorjapan.com/gg/content_image/t0306_003.jpg');
