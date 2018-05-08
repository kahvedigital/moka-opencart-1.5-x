<?php
$moka_url = 'catalog/view/javascript/moka_payment/';
?>
<script src="catalog/view/javascript/moka_payment/card.js"></script>


<link rel="stylesheet" type="text/css" href="catalog/view/javascript/moka_payment/moka.css">
    <form   method="POST"  name="mokapostform"  id="mokapostform" action="<?php echo $action ?>">
        <div class= "row"> 
            <div class="col-xs-12">



                <div id="moka-form" class="mokaform" > 

                    <div class="tum">
                        <h3 class="odemeform-baslik">Ödeme Formu</h3>
                        <div class="hepsi">

                            <div class="demo-container">
                                <div class="info-window cvc " ><div class="arrow-info"></div><div class="cvc-info"><img src="catalog/view/theme/default/image/moka_payment/cvc-help.png"></div></div>

                                <div class="form-group active moka">


                                    <input style="display:none;" name="validform" value="<?php echo $validform; ?>"/>
                                    <div class="mokaname mokafull">
                                        <input class="c-card card-name" placeholder="Kart İsim Soyisim" type="text" required    oninvalid="this.setCustomValidity('Kart sahibinin adını yazınız.')"  oninput="setCustomValidity('')" name="card-name" id="card-name">
                                    </div>
                                    <input value="<?php echo $orderid ?>" name="order_id" type="hidden">

                                        <div class="mokacard mokaorta">
                                            <i class="mokacardicon"></i>
                                            <input id="mokacardnumber" class="c-card cardnumber" placeholder="Kart Numarası" required   oninvalid="this.setCustomValidity('Kartın üzerindeki 16 haneli numarayı giriniz.')" oninput="setCustomValidity('')" type="tel" name="number" >
                                        </div>


                                        <div class="mokaleft mokaexpry">
                                            <input class="c-date c-card"  placeholder="AA/YY" type="tel" maxlength="7" required  oninvalid="this.setCustomValidity('Kartın son kullanma tarihini giriniz')" oninput="setCustomValidity('')" name="expiry" >
                                        </div>

                                        <div class="mokaright mokacvc">
                                            <input class="card-cvc c-card" placeholder="CVC" required  type="number"  oninvalid="this.setCustomValidity('Kartın arkasındaki 3 ya da 4 basamaklı sayıyı giriniz')" oninput="setCustomValidity('')" name="cvc" >
                                                <div class="moka-i-icon"><img src="catalog/view/theme/default/image/moka_payment/icons/info.png" width="14px"> </div>
                                        </div>

                                </div>

                            </div> 

                            <div class="tekcekim-container ">

                                <div class="tekcekim">

                                    <li class="taksit-li " for="s-option" >
                                        <input type="radio" id="s-option"  name="mokatotal"  value="<?php echo $showtotal ?>" checked class="option-input taksitradio radio " >
                                            <label for="s-option">Tek Çekim</label>
                                            <div class="taksit-fiyat"> <?php echo $showtotal; ?></div>
                                            <div class="check"><div class="inside"></div></div>
                                    </li>

                                    <div class="taksit-secenek">
                                        <?php if ($installments_mode == 'ON') { ?>
                                            <h3 class="taksit-secenekleri">Taksit Seçenekleri</h3>

                                            <div class="logolar-moka">

                                                <?php foreach ($rates as $bank => $rate) { ?>

                                                    <?php if ($rates{$bank}['active'] == 1) { ?>

                                                        <div class="moka-banka-logo <?php echo $bank; ?>-logo"><img src="catalog/view/theme/default/image/moka_payment/<?php echo $bank ?>.svg"	></img></div>

                                                    <?php } ?>
                                                <?php } ?>	
                                            </div>

                                        <?php } ?>	
                                    </div>
                                </div>  
                            </div>  
                            <?php if ($installments_mode == 'ON') { ?>
                                <div class="taksit-container ">
                                    <?php foreach ($rates as $bank => $rate) { ?>


                                        <div class="<?php echo $bank; ?>">
                                            <div class="taksit-title "><img src="catalog/view/theme/default/image/moka_payment/<?php echo $bank ?>.svg"></div>

                                            <?php for ($ins = 1; $ins < 13; $ins++) { ?>


                                                <?php foreach ($rates as $banks => $rate) { ?>
                                                    <?php if ($bank == $banks) { ?>
                                                        <?php if ($rates{$bank}['active'] == 1) { ?>
                                                            <?php if ($rates[$banks]['installments']{$ins}['active']) { ?>


                                                                <li class="taksit-li mokaorta">
                                                                    <input type="radio" id="s-option_<?php echo $banks; ?>_<?php echo $ins; ?>" name="mokatotal[<?php echo $banks; ?>][<?php echo $ins; ?>]" value="<?php echo $rates[$banks]['installments'][$ins]['total']; ?>" class="option-input  taksitradio radio">
                                                                        <label for="s-option2"><?php echo $ins ?> Taksit</label>
                                                                        <div class="taksit-fiyat"> <?php echo $rates[$banks]['installments'][$ins]['total']; ?> / <?php echo $rates[$banks]['installments'][$ins]['monthly']; ?> </div>
                                                                        <div class="check"><div class="inside"></div></div>
                                                                </li>

                                                            <?php } ?>

                                                        <?php } ?>

                                                    <?php } ?>
                                                <?php } ?>

                                            <?php } ?>




                                        </div>	


                                    <?php } ?>

                                </div>
                            <?php } ?>	

                            <button type="submit" form="mokapostform" class="mokaode" style=""><span class="mokaOdemeTutar"><?php echo $showtotal; ?></span><span class="mokaOdemeText"> ÖDE</span></button>
                            </form>

                        </div>


                    </div>
                    <div class="card-wrapper" style="margin-left:5px;"></div>
                </div>  


            </div>
        </div>

        <script>
            var theme = "<?php echo $moka_url ?>";
            var taksit = "<?php echo $installments_mode ?>";

        </script>


        <script type="text/javascript">
            new Card({
                form: document.querySelector('.hepsi'),
                container: '.card-wrapper',
                formSelectors: {

                    nameInput: 'input#card-name'
                },

            });
            $(document).ready(function () {
                $('input[type=radio][name=mokatotal]').change(function () {

                    $('.mokaOdemeTutar').text(this.value);

                });


            });

            if (taksit == 'ON') {
                $(document).ready(function () {
                    cardshow(0);
                    $(".maximum-logo").click(function () {
                        cardshow(0);
                        $(".taksit-container").show();
                        $(".maximum").show();
                        $("#s-option_maximum_1").prop('checked', true);
                    });

                    $(".cardfinans-logo").click(function () {
                        cardshow(0);
                        $(".taksit-container").show();
                        $(".cardfinans").show();
                        $("#s-option_cardfinans_1").prop('checked', true);
                    });
                    $(".axess-logo").click(function () {
                        cardshow(0);
                        $(".taksit-container").show();
                        $(".axess").show();
                        $("#s-option_axess_1").prop('checked', true);
                    });
                    $(".bonus-logo").click(function () {
                        cardshow(0);
                        $(".taksit-container").show();
                        $(".bonus").show();
                        $("#s-option_bonus_1").prop('checked', true);
                    });
                    $(".world-logo").click(function () {
                        cardshow(0);
                        $(".taksit-container").show();
                        $(".world").show();
                        $("#s-option_world_1").prop('checked', true);
                    });
                    $(".taksit-li").click(function () {
                        $(".taksit-li").find('input[type="radio"]').removeAttr('checked');
                        $(this).find('input[type="radio"]').prop('checked', true);
                        var price = $(this).find('input[type="radio"]').val();
                        $('.mokaOdemeTutar').text(price);
                    });
                    function cardshow(bankcode) {
                        if (bankcode == '0') {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                        } else if ((bankcode == 62) || (bankcode == 59) || (bankcode == 32) || (bankcode == 99) || (bankcode == 124) || (bankcode == 134) || (bankcode == 206)) {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                            $(".taksit-container").show();
                            $('.bonus').show();
                            $("#s-option_bonus_1").prop('checked', true);
                        } else if ((bankcode == 46) || (bankcode == 92)) {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                            $(".taksit-container").show();
                            $('.axess').show();
                            $("#s-option_axess_1").prop('checked', true);
                        } else if ((bankcode == 64) || (bankcode == 10)) {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                            $(".taksit-container").show();
                            $('.maximum').show();
                            $("#s-option_maximum_1").prop('checked', true);
                        } else if ((bankcode == 15) || (bankcode == 67) || (bankcode == 135) || (bankcode == 203)) {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                            $(".taksit-container").show();
                            $('.world').show();
                            $("#s-option_world_1").prop('checked', true);
                        } else if (bankcode == 111) {
                            $(".taksit-container").hide();
                            $(".taksit-container").children().hide();
                            $(".taksit-container").show();
                            $('.cardfinans').show();
                        }
                    }
                    $.ajaxSetup({cache: false});
                    $('#mokacardnumber').keyup(function () {
                        var searchField = $('#mokacardnumber').val();
                        searchField = searchField.replace(/\s/g, '');
                        if (searchField.length < 6) {
                            cardshow(0);
                            return;
                        }
                        ;
                        if (searchField.length > 6)
                            return;

                        $.getJSON('' + theme + 'bins.json', function (data) {

                            $.each(data, function (key, value) {

                                if (value.bin_number == searchField)
                                {

                                    cardshow(value.bank_code);
                                }
                            });
                        });
                    });

                });
            }

            $(".moka-i-icon img").hover(function () {
                $(".info-window").toggleClass("info-window-active");
            });

            $('.c-card').bind('keypress keyup keydown focus', function (e) {
                var ErrorInput = false;
                if ($("input.card-name").hasClass("jp-card-invalid")) {
                    ErrorInput = true;
                    $("input.card-name").addClass("border");
                }
                if ($("input.cardnumber").hasClass("jp-card-invalid")) {
                    ErrorInput = true;
                    $("input.cardnumber").addClass("border");
                }
                if ($("input.c-date").hasClass("jp-card-invalid")) {
                    ErrorInput = true;
                    $("input.c-date").addClass("border");
                }
                if ($("input.card-cvc").hasClass("jp-card-invalid")) {
                    ErrorInput = true;
                    $("input.card-cvc").addClass("border");
                }
                if (ErrorInput === true) {
                    $('.mokaode').attr("disabled", true);
                    $(".mokaode").css("opacity", "0.5");

                } else {

                    $("input.card-name").removeClass("border");
                    $("input.cardnumber").removeClass("border");
                    $("input.c-date").removeClass("border");
                    $("input.card-cvc").removeClass("border");
                    $('.mokaode').attr("disabled", false);
                    $(".mokaode").css("opacity", "1");

                }

            });



        </script>
