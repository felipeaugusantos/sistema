object frmQckBancoPadrao: TfrmQckBancoPadrao
  Left = 199
  Top = 22
  Width = 818
  Height = 780
  AutoScroll = True
  Caption = 'frmQckBancoPadrao'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object qckBoleto: TRLReport
    Left = 0
    Top = 46
    Width = 794
    Height = 1123
    Margins.TopMargin = 8.000000000000000000
    Borders.Sides = sdCustom
    Borders.DrawLeft = False
    Borders.DrawTop = False
    Borders.DrawRight = False
    Borders.DrawBottom = False
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PrintDialog = False
    Transparent = False
    BeforePrint = qckBoletoBeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 30
      Width = 718
      Height = 1053
      BandType = btTitle
      Transparent = False
      object rlpBandaB: TRLPanel
        Left = 0
        Top = 128
        Width = 718
        Height = 289
        Align = faBottom
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Transparent = False
        object RLPanel2: TRLPanel
          Left = 1
          Top = 1
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object rlpLogotipo: TRLPanel
            Left = 0
            Top = 0
            Width = 141
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object rlmLogotiB: TRLImage
              Left = 0
              Top = 0
              Width = 141
              Height = 24
              Align = faClient
              Stretch = True
              Transparent = False
            end
          end
          object RLPanel3: TRLPanel
            Left = 141
            Top = 0
            Width = 81
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = True
            Borders.DrawBottom = False
            Transparent = False
            object rllBanDigB: TRLLabel
              Left = 17
              Top = 4
              Width = 46
              Height = 19
              Alignment = taCenter
              Caption = '000-0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel4: TRLPanel
            Left = 222
            Top = 0
            Width = 494
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel33: TRLLabel
              Left = 311
              Top = 4
              Width = 100
              Height = 16
              Caption = 'Ficha de Caixa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel5: TRLPanel
          Left = 1
          Top = 26
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel6: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel3: TRLLabel
              Left = 0
              Top = 0
              Width = 70
              Height = 10
              Align = faLeftTop
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllLocPagB: TRLLabel
              Left = 0
              Top = 11
              Width = 538
              Height = 13
              AutoSize = False
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel13: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel4: TRLLabel
              Left = 1
              Top = 0
              Width = 41
              Height = 10
              Align = faLeftTop
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllVencimB: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel7: TRLPanel
          Left = 1
          Top = 51
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel14: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel5: TRLLabel
              Left = 0
              Top = 0
              Width = 42
              Height = 10
              Align = faLeftTop
              Caption = 'Benefici'#225'rio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomCedB: TRLLabel
              Left = 0
              Top = 10
              Width = 538
              Height = 14
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel15: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel6: TRLLabel
              Left = 1
              Top = 0
              Width = 78
              Height = 10
              Align = faLeftTop
              Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAgeCedB: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Ag'#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel8: TRLPanel
          Left = 1
          Top = 76
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel16: TRLPanel
            Left = 0
            Top = 0
            Width = 105
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel7: TRLLabel
              Left = 0
              Top = 0
              Width = 68
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaDocB: TRLLabel
              Left = 0
              Top = 10
              Width = 100
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Data Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel17: TRLPanel
            Left = 105
            Top = 0
            Width = 152
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel8: TRLLabel
              Left = 1
              Top = 0
              Width = 61
              Height = 10
              Align = faLeftTop
              Caption = 'N'#186' do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNumDocB: TRLLabel
              Left = 1
              Top = 10
              Width = 146
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Numero Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel18: TRLPanel
            Left = 257
            Top = 0
            Width = 88
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel9: TRLLabel
              Left = 1
              Top = 0
              Width = 47
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspDocB: TRLLabel
              Left = 1
              Top = 10
              Width = 70
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Esp. Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel19: TRLPanel
            Left = 345
            Top = 0
            Width = 64
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel10: TRLLabel
              Left = 1
              Top = 0
              Width = 23
              Height = 10
              Align = faLeftTop
              Caption = 'Aceite'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAceiteB: TRLLabel
              Left = 1
              Top = 10
              Width = 60
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'N'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel20: TRLPanel
            Left = 409
            Top = 0
            Width = 136
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel11: TRLLabel
              Left = 1
              Top = 0
              Width = 82
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaProB: TRLLabel
              Left = 1
              Top = 10
              Width = 128
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Dta. Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel21: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel12: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira/Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNosNumB: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Nosso Numero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel9: TRLPanel
          Left = 1
          Top = 101
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel22: TRLPanel
            Left = 0
            Top = 0
            Width = 169
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel13: TRLLabel
              Left = 0
              Top = 0
              Width = 49
              Height = 10
              Align = faLeftTop
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllUsoBanB: TRLLabel
              Left = 0
              Top = 10
              Width = 163
              Height = 14
              AutoSize = False
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel23: TRLPanel
            Left = 169
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel14: TRLLabel
              Left = 1
              Top = 0
              Width = 30
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCarteiB: TRLLabel
              Left = 1
              Top = 10
              Width = 58
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel24: TRLPanel
            Left = 241
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel15: TRLLabel
              Left = 1
              Top = 0
              Width = 64
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspMoeB: TRLLabel
              Left = 1
              Top = 10
              Width = 72
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'R$'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel25: TRLPanel
            Left = 313
            Top = 0
            Width = 120
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel16: TRLLabel
              Left = 1
              Top = 0
              Width = 40
              Height = 10
              Align = faLeftTop
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllQuantiB: TRLLabel
              Left = 1
              Top = 10
              Width = 62
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel26: TRLPanel
            Left = 433
            Top = 0
            Width = 112
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel17: TRLLabel
              Left = 1
              Top = 0
              Width = 55
              Height = 10
              Align = faLeftTop
              Caption = 'Valor da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValMoeB: TRLLabel
              Left = 1
              Top = 10
              Width = 104
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel27: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel18: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = '(=) Valor do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValDocB: TRLLabel
              Left = 1
              Top = 8
              Width = 65
              Height = 16
              Align = faLeftBottom
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Valor Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel10: TRLPanel
          Left = 1
          Top = 126
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel28: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel19: TRLLabel
              Left = 2
              Top = 0
              Width = 84
              Height = 10
              Caption = '(-) Desconto/Abatimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel29: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object RLLabel20: TRLLabel
              Left = 0
              Top = 0
              Width = 37
              Height = 10
              Align = faLeftTop
              Caption = 'Instru'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInstru1B: TRLLabel
              Left = 58
              Top = 0
              Width = 471
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru2B: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel11: TRLPanel
          Left = 1
          Top = 147
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel30: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru3B: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru4B: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel31: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel22: TRLLabel
              Left = 2
              Top = 0
              Width = 72
              Height = 10
              Caption = '(-) Outras Dedu'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel12: TRLPanel
          Left = 1
          Top = 168
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel35: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru5B: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru6B: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel36: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel21: TRLLabel
              Left = 2
              Top = 0
              Width = 54
              Height = 10
              Caption = '(+) Mora/Multa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel32: TRLPanel
          Left = 1
          Top = 189
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel37: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel23: TRLLabel
              Left = 2
              Top = 0
              Width = 80
              Height = 10
              Caption = '(+) Outros Acr'#233'scimos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel38: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru7B: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru8B: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel33: TRLPanel
          Left = 1
          Top = 210
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel39: TRLPanel
            Left = 0
            Top = 0
            Width = 543
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru9B: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru10B: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel40: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 20
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel24: TRLLabel
              Left = 2
              Top = 0
              Width = 64
              Height = 10
              Caption = '(=) Valor Cobrado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel34: TRLPanel
          Left = 1
          Top = 231
          Width = 716
          Height = 45
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel41: TRLPanel
            Left = 0
            Top = 0
            Width = 716
            Height = 44
            Align = faTop
            Transparent = False
            object RLLabel25: TRLLabel
              Left = 0
              Top = 0
              Width = 33
              Height = 10
              Align = faLeftTop
              Caption = 'Pagador:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomSacB: TRLLabel
              Left = 40
              Top = 1
              Width = 59
              Height = 10
              Caption = 'Nome do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEndSacB: TRLLabel
              Left = 40
              Top = 12
              Width = 71
              Height = 10
              Caption = 'Endere'#231'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCepCidB: TRLLabel
              Left = 40
              Top = 23
              Width = 106
              Height = 10
              Caption = 'Cep./Cidade/Estado do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllSacadorB: TRLLabel
              Left = 0
              Top = 34
              Width = 60
              Height = 10
              Align = faLeftBottom
              Caption = 'Sacador/Avalista:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInsSacB: TRLLabel
              Left = 440
              Top = 1
              Width = 70
              Height = 10
              Caption = 'Inscri'#231#227'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCodBaiB: TRLLabel
              Left = 544
              Top = 32
              Width = 172
              Height = 10
              Alignment = taCenter
              AutoSize = False
              Caption = 'C'#243'digo de Baixa Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLLabel32: TRLLabel
          Left = 545
          Top = 277
          Width = 172
          Height = 10
          Alignment = taCenter
          AutoSize = False
          Caption = 'Autentica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
      end
      object rlpBandaC: TRLPanel
        Left = 0
        Top = 430
        Width = 718
        Height = 289
        Align = faBottom
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Transparent = False
        object RLPanel43: TRLPanel
          Left = 1
          Top = 1
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel44: TRLPanel
            Left = 0
            Top = 0
            Width = 141
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object rlmLogotiC: TRLImage
              Left = 0
              Top = 0
              Width = 141
              Height = 24
              Align = faClient
              Stretch = True
              Transparent = False
            end
          end
          object RLPanel45: TRLPanel
            Left = 141
            Top = 0
            Width = 81
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = True
            Borders.DrawBottom = False
            Transparent = False
            object rllBanDigC: TRLLabel
              Left = 17
              Top = 4
              Width = 46
              Height = 19
              Alignment = taCenter
              Caption = '000-0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel46: TRLPanel
            Left = 222
            Top = 0
            Width = 483
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel30: TRLLabel
              Left = 311
              Top = 4
              Width = 120
              Height = 16
              Caption = 'Recibo do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel47: TRLPanel
          Left = 1
          Top = 26
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel48: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel34: TRLLabel
              Left = 0
              Top = 0
              Width = 70
              Height = 10
              Align = faLeftTop
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllLocPagC: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 14
              AutoSize = False
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel49: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel35: TRLLabel
              Left = 1
              Top = 0
              Width = 41
              Height = 10
              Align = faLeftTop
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllVencimC: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel50: TRLPanel
          Left = 1
          Top = 51
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel51: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel36: TRLLabel
              Left = 0
              Top = 0
              Width = 42
              Height = 10
              Align = faLeftTop
              Caption = 'Benefici'#225'rio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomCedC: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 14
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel52: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel37: TRLLabel
              Left = 1
              Top = 0
              Width = 78
              Height = 10
              Align = faLeftTop
              Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAgeCedC: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Ag'#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel53: TRLPanel
          Left = 1
          Top = 76
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel54: TRLPanel
            Left = 0
            Top = 0
            Width = 105
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel38: TRLLabel
              Left = 0
              Top = 0
              Width = 68
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaDocC: TRLLabel
              Left = 0
              Top = 10
              Width = 100
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Data Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel55: TRLPanel
            Left = 105
            Top = 0
            Width = 152
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel39: TRLLabel
              Left = 1
              Top = 0
              Width = 61
              Height = 10
              Align = faLeftTop
              Caption = 'N'#186' do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNumDocC: TRLLabel
              Left = 1
              Top = 10
              Width = 146
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Numero Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel56: TRLPanel
            Left = 257
            Top = 0
            Width = 88
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel40: TRLLabel
              Left = 1
              Top = 0
              Width = 47
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspDocC: TRLLabel
              Left = 1
              Top = 10
              Width = 70
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Esp. Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel57: TRLPanel
            Left = 345
            Top = 0
            Width = 64
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel41: TRLLabel
              Left = 1
              Top = 0
              Width = 23
              Height = 10
              Align = faLeftTop
              Caption = 'Aceite'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAceiteC: TRLLabel
              Left = 1
              Top = 10
              Width = 60
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'N'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel58: TRLPanel
            Left = 409
            Top = 0
            Width = 136
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel42: TRLLabel
              Left = 1
              Top = 0
              Width = 82
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaProC: TRLLabel
              Left = 1
              Top = 10
              Width = 120
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Dta. Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel59: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel43: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira/Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNosNumC: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Nosso Numero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel60: TRLPanel
          Left = 1
          Top = 101
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel61: TRLPanel
            Left = 0
            Top = 0
            Width = 169
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel44: TRLLabel
              Left = 0
              Top = 0
              Width = 49
              Height = 10
              Align = faLeftTop
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllUsoBanC: TRLLabel
              Left = 0
              Top = 10
              Width = 163
              Height = 14
              AutoSize = False
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel62: TRLPanel
            Left = 169
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel45: TRLLabel
              Left = 1
              Top = 0
              Width = 30
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCarteiC: TRLLabel
              Left = 1
              Top = 10
              Width = 58
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel63: TRLPanel
            Left = 241
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel46: TRLLabel
              Left = 1
              Top = 0
              Width = 64
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspMoeC: TRLLabel
              Left = 1
              Top = 10
              Width = 72
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'R$'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel64: TRLPanel
            Left = 313
            Top = 0
            Width = 120
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel47: TRLLabel
              Left = 1
              Top = 0
              Width = 40
              Height = 10
              Align = faLeftTop
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllQuantiC: TRLLabel
              Left = 1
              Top = 10
              Width = 62
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel65: TRLPanel
            Left = 433
            Top = 0
            Width = 112
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel48: TRLLabel
              Left = 1
              Top = 0
              Width = 55
              Height = 10
              Align = faLeftTop
              Caption = 'Valor da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValMoeC: TRLLabel
              Left = 1
              Top = 10
              Width = 96
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel66: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel49: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = '(=) Valor do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValDocC: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Valor Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel67: TRLPanel
          Left = 1
          Top = 126
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel68: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel50: TRLLabel
              Left = 2
              Top = 0
              Width = 84
              Height = 10
              Caption = '(-) Desconto/Abatimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel69: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object RLLabel51: TRLLabel
              Left = 0
              Top = 0
              Width = 37
              Height = 10
              Align = faLeftTop
              Caption = 'Instru'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInstru1C: TRLLabel
              Left = 58
              Top = 0
              Width = 471
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru2C: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel70: TRLPanel
          Left = 1
          Top = 147
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel71: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru3C: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru4C: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel72: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel52: TRLLabel
              Left = 2
              Top = 0
              Width = 72
              Height = 10
              Caption = '(-) Outras Dedu'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel73: TRLPanel
          Left = 1
          Top = 168
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel74: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru5C: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru6C: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel75: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel53: TRLLabel
              Left = 2
              Top = 0
              Width = 54
              Height = 10
              Caption = '(+) Mora/Multa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel76: TRLPanel
          Left = 1
          Top = 189
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel77: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel54: TRLLabel
              Left = 2
              Top = 0
              Width = 80
              Height = 10
              Caption = '(+) Outros Acr'#233'scimos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel78: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru7C: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru8C: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel79: TRLPanel
          Left = 1
          Top = 210
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel80: TRLPanel
            Left = 0
            Top = 0
            Width = 543
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru9C: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru10C: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel81: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 20
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel55: TRLLabel
              Left = 2
              Top = 0
              Width = 64
              Height = 10
              Caption = '(=) Valor Cobrado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel82: TRLPanel
          Left = 1
          Top = 231
          Width = 716
          Height = 45
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel83: TRLPanel
            Left = 0
            Top = 0
            Width = 716
            Height = 44
            Align = faTop
            Transparent = False
            object RLLabel56: TRLLabel
              Left = 0
              Top = 0
              Width = 33
              Height = 10
              Align = faLeftTop
              Caption = 'Pagador:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomSacC: TRLLabel
              Left = 40
              Top = 1
              Width = 59
              Height = 10
              Caption = 'Nome do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEndSacC: TRLLabel
              Left = 40
              Top = 12
              Width = 71
              Height = 10
              Caption = 'Endere'#231'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCepCidC: TRLLabel
              Left = 40
              Top = 23
              Width = 106
              Height = 10
              Caption = 'Cep./Cidade/Estado do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllSacadorC: TRLLabel
              Left = 0
              Top = 34
              Width = 60
              Height = 10
              Align = faLeftBottom
              Caption = 'Sacador/Avalista:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInsSacC: TRLLabel
              Left = 440
              Top = 1
              Width = 70
              Height = 10
              Caption = 'Inscri'#231#227'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCodBaiC: TRLLabel
              Left = 650
              Top = 28
              Width = 66
              Height = 16
              Align = faRightBottom
              Alignment = taCenter
              AutoSize = False
              Caption = 'C'#243'digo de Baixa Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLLabel63: TRLLabel
          Left = 545
          Top = 277
          Width = 172
          Height = 10
          Alignment = taCenter
          AutoSize = False
          Caption = 'Autentica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
      end
      object pnlCortaB: TRLPanel
        Left = 0
        Top = 417
        Width = 718
        Height = 13
        Align = faBottom
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLPanel154: TRLPanel
          Left = 0
          Top = 1
          Width = 718
          Height = 12
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLLabel26: TRLLabel
            Left = 0
            Top = -2
            Width = 896
            Height = 14
            Caption = 
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel27: TRLLabel
            Left = 683
            Top = -2
            Width = 28
            Height = 15
            Caption = '"'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Wingdings'
            Font.Style = []
            ParentFont = False
          end
        end
      end
      object rlpBandaD: TRLPanel
        Left = 0
        Top = 729
        Width = 718
        Height = 324
        Align = faBottom
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = False
        Transparent = False
        object RLPanel86: TRLPanel
          Left = 1
          Top = 1
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel87: TRLPanel
            Left = 0
            Top = 0
            Width = 141
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object rlmLogotiD: TRLImage
              Left = 0
              Top = 0
              Width = 141
              Height = 24
              Align = faClient
              Stretch = True
              Transparent = False
            end
          end
          object RLPanel88: TRLPanel
            Left = 141
            Top = 0
            Width = 81
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = True
            Borders.DrawBottom = False
            Transparent = False
            object rllBanDigD: TRLLabel
              Left = 17
              Top = 4
              Width = 46
              Height = 19
              Alignment = taCenter
              Caption = '000-0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel89: TRLPanel
            Left = 222
            Top = 0
            Width = 491
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object rllLinDig: TRLLabel
              Left = 5
              Top = 3
              Width = 484
              Height = 18
              Alignment = taCenter
              AutoSize = False
              Caption = '00000.00000 00000.000000 00000.000000 0 0000000000000'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel90: TRLPanel
          Left = 1
          Top = 26
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel91: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel67: TRLLabel
              Left = 0
              Top = 0
              Width = 70
              Height = 10
              Align = faLeftTop
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllLocPagD: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 14
              AutoSize = False
              Caption = 'Local de Pagamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel92: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel68: TRLLabel
              Left = 1
              Top = 0
              Width = 41
              Height = 10
              Align = faLeftTop
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllVencimD: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Vencimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel93: TRLPanel
          Left = 1
          Top = 51
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel94: TRLPanel
            Left = 0
            Top = 0
            Width = 544
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel69: TRLLabel
              Left = 0
              Top = 0
              Width = 42
              Height = 10
              Align = faLeftTop
              Caption = 'Benefici'#225'rio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomCedD: TRLLabel
              Left = 0
              Top = 9
              Width = 529
              Height = 14
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel95: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel70: TRLLabel
              Left = 1
              Top = 0
              Width = 78
              Height = 10
              Align = faLeftTop
              Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAgeCedD: TRLLabel
              Left = 0
              Top = 10
              Width = 161
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Ag'#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel96: TRLPanel
          Left = 1
          Top = 76
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel97: TRLPanel
            Left = 0
            Top = 0
            Width = 105
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel71: TRLLabel
              Left = 0
              Top = 0
              Width = 68
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaDocD: TRLLabel
              Left = 0
              Top = 10
              Width = 100
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Data Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel98: TRLPanel
            Left = 105
            Top = 0
            Width = 152
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel72: TRLLabel
              Left = 1
              Top = 0
              Width = 61
              Height = 10
              Align = faLeftTop
              Caption = 'N'#186' do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNumDocD: TRLLabel
              Left = 1
              Top = 10
              Width = 146
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Numero Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel99: TRLPanel
            Left = 257
            Top = 0
            Width = 88
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel73: TRLLabel
              Left = 1
              Top = 0
              Width = 47
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspDocD: TRLLabel
              Left = 1
              Top = 10
              Width = 70
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Esp. Doc.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel100: TRLPanel
            Left = 345
            Top = 0
            Width = 64
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel74: TRLLabel
              Left = 1
              Top = 0
              Width = 23
              Height = 10
              Align = faLeftTop
              Caption = 'Aceite'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllAceiteD: TRLLabel
              Left = 1
              Top = 10
              Width = 60
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'N'#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel101: TRLPanel
            Left = 409
            Top = 0
            Width = 136
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel75: TRLLabel
              Left = 1
              Top = 0
              Width = 82
              Height = 10
              Align = faLeftTop
              Caption = 'Data do Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllDtaProD: TRLLabel
              Left = 1
              Top = 10
              Width = 120
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Dta. Processamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel102: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel76: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira/Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNosNumD: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Nosso Numero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel103: TRLPanel
          Left = 1
          Top = 101
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel104: TRLPanel
            Left = 0
            Top = 0
            Width = 169
            Height = 24
            Align = faLeftTop
            Transparent = False
            object RLLabel77: TRLLabel
              Left = 0
              Top = 0
              Width = 49
              Height = 10
              Align = faLeftTop
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllUsoBanD: TRLLabel
              Left = 1
              Top = 9
              Width = 162
              Height = 14
              AutoSize = False
              Caption = 'Uso do Banco'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel105: TRLPanel
            Left = 169
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel78: TRLLabel
              Left = 1
              Top = 0
              Width = 30
              Height = 10
              Align = faLeftTop
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCarteiD: TRLLabel
              Left = 1
              Top = 10
              Width = 58
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'Carteira'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel106: TRLPanel
            Left = 241
            Top = 0
            Width = 72
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel79: TRLLabel
              Left = 1
              Top = 0
              Width = 64
              Height = 10
              Align = faLeftTop
              Caption = 'Esp'#233'cie da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEspMoeD: TRLLabel
              Left = 1
              Top = 10
              Width = 72
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = 'R$'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel107: TRLPanel
            Left = 313
            Top = 0
            Width = 120
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel80: TRLLabel
              Left = 1
              Top = 0
              Width = 40
              Height = 10
              Align = faLeftTop
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllQuantiD: TRLLabel
              Left = 1
              Top = 10
              Width = 62
              Height = 14
              Alignment = taCenter
              AutoSize = False
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel108: TRLPanel
            Left = 433
            Top = 0
            Width = 112
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel81: TRLLabel
              Left = 1
              Top = 0
              Width = 55
              Height = 10
              Align = faLeftTop
              Caption = 'Valor da Moeda'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValMoeD: TRLLabel
              Left = 1
              Top = 10
              Width = 96
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel109: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 24
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Color = clSilver
            ParentColor = False
            Transparent = False
            object RLLabel82: TRLLabel
              Left = 1
              Top = 0
              Width = 83
              Height = 10
              Align = faLeftTop
              Caption = '(=) Valor do Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllValDocD: TRLLabel
              Left = 1
              Top = 10
              Width = 160
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Valor Documento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel110: TRLPanel
          Left = 1
          Top = 126
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel111: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel83: TRLLabel
              Left = 2
              Top = 0
              Width = 84
              Height = 10
              Caption = '(-) Desconto/Abatimento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel112: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel84: TRLLabel
              Left = 0
              Top = 0
              Width = 37
              Height = 10
              Align = faLeftTop
              Caption = 'Instru'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInstru1D: TRLLabel
              Left = 58
              Top = 0
              Width = 471
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru2D: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel113: TRLPanel
          Left = 1
          Top = 147
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel114: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru3D: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru4D: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel115: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel85: TRLLabel
              Left = 2
              Top = 0
              Width = 72
              Height = 10
              Caption = '(-) Outras Dedu'#231#245'es'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel116: TRLPanel
          Left = 1
          Top = 168
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel117: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru5D: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru6D: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel118: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel86: TRLLabel
              Left = 2
              Top = 0
              Width = 54
              Height = 10
              Caption = '(+) Mora/Multa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel119: TRLPanel
          Left = 1
          Top = 189
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Transparent = False
          object RLPanel120: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 21
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
            object RLLabel87: TRLLabel
              Left = 2
              Top = 0
              Width = 80
              Height = 10
              Caption = '(+) Outros Acr'#233'scimos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel121: TRLPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru7D: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru8D: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel122: TRLPanel
          Left = 1
          Top = 210
          Width = 716
          Height = 21
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel123: TRLPanel
            Left = 0
            Top = 0
            Width = 543
            Height = 20
            Align = faLeftTop
            Transparent = False
            object rllInstru9D: TRLLabel
              Left = 0
              Top = 0
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
            object rllInstru10D: TRLLabel
              Left = 0
              Top = 10
              Width = 529
              Height = 10
              AutoSize = False
              Caption = 'Nome do Cedente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel124: TRLPanel
            Left = 544
            Top = 0
            Width = 172
            Height = 20
            Align = faRightTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel88: TRLLabel
              Left = 2
              Top = 0
              Width = 64
              Height = 10
              Caption = '(=) Valor Cobrado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel125: TRLPanel
          Left = 1
          Top = 231
          Width = 716
          Height = 45
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel126: TRLPanel
            Left = 0
            Top = 0
            Width = 716
            Height = 44
            Align = faTop
            Transparent = False
            object RLLabel89: TRLLabel
              Left = 0
              Top = 0
              Width = 33
              Height = 10
              Align = faLeftTop
              Caption = 'Pagador:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllNomSacD: TRLLabel
              Left = 40
              Top = 1
              Width = 59
              Height = 10
              Caption = 'Nome do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllEndSacD: TRLLabel
              Left = 40
              Top = 12
              Width = 71
              Height = 10
              Caption = 'Endere'#231'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCepCidD: TRLLabel
              Left = 40
              Top = 23
              Width = 106
              Height = 10
              Caption = 'Cep./Cidade/Estado do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllSacadorD: TRLLabel
              Left = 0
              Top = 34
              Width = 60
              Height = 10
              Align = faLeftBottom
              Caption = 'Sacador/Avalista:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllInsSacD: TRLLabel
              Left = 440
              Top = 1
              Width = 70
              Height = 10
              Caption = 'Inscri'#231#227'o do Sacado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
            object rllCodBaiD: TRLLabel
              Left = 650
              Top = 28
              Width = 66
              Height = 16
              Align = faRightBottom
              Alignment = taCenter
              AutoSize = False
              Caption = 'C'#243'digo de Baixa Nosso N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -8
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLLabel96: TRLLabel
          Left = 545
          Top = 277
          Width = 172
          Height = 10
          Alignment = taCenter
          AutoSize = False
          Caption = 'Autentica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object RLLabel97: TRLLabel
          Left = 552
          Top = 288
          Width = 153
          Height = 16
          Caption = 'Ficha de Compensa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object rllCodBar: TRLBarcode
          Left = 4
          Top = 278
          Width = 424
          Height = 46
          Margins.LeftMargin = 1.000000000000000000
          Margins.RightMargin = 1.000000000000000000
          AutoSize = False
          Caption = '12345678901234567890123456789012345678901234'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Ratio = 3.000000000000000000
          Transparent = False
        end
      end
      object rlpBandaA: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 121
        Align = faBottom
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = False
        Borders.FixedRight = True
        Transparent = False
        object RLPanel127: TRLPanel
          Left = 1
          Top = 1
          Width = 716
          Height = 25
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLPanel128: TRLPanel
            Left = 0
            Top = 0
            Width = 141
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = True
            Borders.DrawBottom = False
            Transparent = False
            object rlmLogotiA: TRLImage
              Left = 0
              Top = 0
              Width = 140
              Height = 24
              Align = faClient
              Center = True
              Stretch = True
              Transparent = False
            end
          end
          object RLPanel129: TRLPanel
            Left = 141
            Top = 0
            Width = 81
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = True
            Borders.DrawBottom = False
            Transparent = False
            object rllBanDigA: TRLLabel
              Left = 17
              Top = 4
              Width = 46
              Height = 19
              Alignment = taCenter
              Caption = '000-0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
          object RLPanel130: TRLPanel
            Left = 222
            Top = 0
            Width = 494
            Height = 24
            Align = faLeftTop
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = False
            Transparent = False
            object RLLabel98: TRLLabel
              Left = 163
              Top = 4
              Width = 162
              Height = 16
              Alignment = taCenter
              Caption = 'Comprovante de Entrega'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
            end
          end
        end
        object RLPanel133: TRLPanel
          Left = 465
          Top = 26
          Width = 252
          Height = 94
          Align = faRightTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel101: TRLLabel
            Left = 1
            Top = 0
            Width = 72
            Height = 16
            Align = faLeftTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Motivos de n'#227'o entrega. (Para uso da empresa entregadora)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel137: TRLPanel
            Left = 139
            Top = 11
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel104: TRLLabel
            Left = 153
            Top = 11
            Width = 74
            Height = 10
            Caption = 'Endere'#231'o Insuficiente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel131: TRLPanel
            Left = 68
            Top = 11
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel102: TRLLabel
            Left = 81
            Top = 11
            Width = 31
            Height = 10
            Caption = 'Falecido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel136: TRLPanel
            Left = 4
            Top = 11
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel103: TRLLabel
            Left = 17
            Top = 11
            Width = 36
            Height = 10
            Caption = 'Mudou-se'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel138: TRLPanel
            Left = 139
            Top = 21
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel105: TRLLabel
            Left = 153
            Top = 21
            Width = 84
            Height = 10
            Caption = 'N'#227'o existe o N'#186' indicado'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel139: TRLPanel
            Left = 68
            Top = 21
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel106: TRLLabel
            Left = 81
            Top = 21
            Width = 50
            Height = 10
            Caption = 'Desconhecido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel140: TRLPanel
            Left = 4
            Top = 21
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel107: TRLLabel
            Left = 17
            Top = 21
            Width = 36
            Height = 10
            Caption = 'Recusado'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel141: TRLPanel
            Left = 139
            Top = 31
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel108: TRLLabel
            Left = 153
            Top = 31
            Width = 87
            Height = 10
            Caption = 'Outros (Anotar no Verso)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel142: TRLPanel
            Left = 68
            Top = 31
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel109: TRLLabel
            Left = 81
            Top = 31
            Width = 52
            Height = 10
            Caption = 'N'#227'o procurado'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel143: TRLPanel
            Left = 4
            Top = 31
            Width = 13
            Height = 9
            Borders.Sides = sdCustom
            Borders.DrawLeft = True
            Borders.DrawTop = True
            Borders.DrawRight = True
            Borders.DrawBottom = True
            Transparent = False
          end
          object RLLabel110: TRLLabel
            Left = 17
            Top = 31
            Width = 29
            Height = 10
            Caption = 'Ausente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel111: TRLLabel
            Left = 41
            Top = 80
            Width = 18
            Height = 10
            Caption = 'Data'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel112: TRLLabel
            Left = 169
            Top = 80
            Width = 40
            Height = 10
            Caption = 'Entregador'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLPanel144: TRLPanel
            Left = 14
            Top = 76
            Width = 231
            Height = 2
            Borders.Sides = sdCustom
            Borders.DrawLeft = False
            Borders.DrawTop = False
            Borders.DrawRight = False
            Borders.DrawBottom = True
            Transparent = False
          end
        end
        object RLPanel132: TRLPanel
          Left = 319
          Top = 48
          Width = 146
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel100: TRLLabel
            Left = 1
            Top = 0
            Width = 83
            Height = 10
            Align = faLeftTop
            Caption = 'Carteira/Nosso N'#250'mero'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNosNumA: TRLLabel
            Left = 1
            Top = 10
            Width = 139
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Nosso Numero'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel135: TRLPanel
          Left = 1
          Top = 48
          Width = 318
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel99: TRLLabel
            Left = 0
            Top = 0
            Width = 31
            Height = 10
            Align = faLeftTop
            Caption = 'Pagador'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNomSacA: TRLLabel
            Left = 0
            Top = 10
            Width = 312
            Height = 13
            AutoSize = False
            Caption = 'Nome do Cedente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel145: TRLPanel
          Left = 319
          Top = 26
          Width = 146
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel113: TRLLabel
            Left = 1
            Top = 0
            Width = 78
            Height = 10
            Align = faLeftTop
            Caption = 'Ag'#234'ncia/C'#243'd. Cedente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllAgeCedA: TRLLabel
            Left = 1
            Top = 10
            Width = 139
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Ag'#234'ncia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel146: TRLPanel
          Left = 1
          Top = 26
          Width = 318
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel114: TRLLabel
            Left = 0
            Top = 0
            Width = 42
            Height = 10
            Align = faLeftTop
            Caption = 'Benefici'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNomCedA: TRLLabel
            Left = 0
            Top = 10
            Width = 312
            Height = 13
            AutoSize = False
            Caption = 'Nome do Cedente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel149: TRLPanel
          Left = 1
          Top = 72
          Width = 120
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clSilver
          ParentColor = False
          Transparent = False
          object RLLabel117: TRLLabel
            Left = 0
            Top = 0
            Width = 41
            Height = 10
            Align = faLeftTop
            Caption = 'Vencimento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllVencimA: TRLLabel
            Left = 0
            Top = 10
            Width = 116
            Height = 13
            Alignment = taJustify
            AutoSize = False
            Caption = 'Vencimento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel150: TRLPanel
          Left = 319
          Top = 72
          Width = 146
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clSilver
          ParentColor = False
          Transparent = False
          object RLLabel118: TRLLabel
            Left = 1
            Top = 0
            Width = 83
            Height = 10
            Align = faLeftTop
            Caption = '(=) Valor do Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllValDocA: TRLLabel
            Left = 1
            Top = 10
            Width = 139
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel151: TRLPanel
          Left = 121
          Top = 72
          Width = 140
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel119: TRLLabel
            Left = 1
            Top = 0
            Width = 63
            Height = 10
            Align = faLeftTop
            Caption = 'N.'#186' do Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNumDocA: TRLLabel
            Left = 1
            Top = 10
            Width = 134
            Height = 13
            Alignment = taCenter
            AutoSize = False
            Caption = 'Numero Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel152: TRLPanel
          Left = 261
          Top = 72
          Width = 58
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel120: TRLLabel
            Left = 1
            Top = 0
            Width = 42
            Height = 10
            Align = faLeftTop
            Caption = 'Esp. Moeda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllEspMoeA: TRLLabel
            Left = 1
            Top = 10
            Width = 54
            Height = 13
            Alignment = taCenter
            AutoSize = False
            Caption = 'R$'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel147: TRLPanel
          Left = 1
          Top = 96
          Width = 120
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel115: TRLLabel
            Left = 0
            Top = 0
            Width = 108
            Height = 10
            Align = faLeftTop
            Caption = 'Recebi(emos) o bloqueto/T'#237'tulo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel116: TRLLabel
            Left = 0
            Top = 10
            Width = 100
            Height = 10
            Caption = 'com as caracter'#237'sticas acima'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel148: TRLPanel
          Left = 121
          Top = 96
          Width = 140
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel121: TRLLabel
            Left = 2
            Top = 0
            Width = 18
            Height = 10
            Caption = 'Data'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel153: TRLPanel
          Left = 261
          Top = 96
          Width = 204
          Height = 24
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Transparent = False
          object RLLabel122: TRLLabel
            Left = 2
            Top = 0
            Width = 38
            Height = 10
            Caption = 'Assinatura'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
      end
      object pnlCortaC: TRLPanel
        Left = 0
        Top = 719
        Width = 718
        Height = 10
        Align = faBottom
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLLabel1: TRLLabel
          Left = -94
          Top = -3
          Width = 896
          Height = 14
          Caption = 
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RLLabel2: TRLLabel
          Left = 683
          Top = -3
          Width = 28
          Height = 15
          Caption = '"'
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Wingdings'
          Font.Style = []
          ParentFont = False
        end
      end
      object pnlCortaA: TRLPanel
        Left = 0
        Top = 121
        Width = 718
        Height = 7
        Align = faBottom
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Style = bsHorizontal
        Color = clWhite
        ParentColor = False
        Transparent = False
        object RLPanel155: TRLPanel
          Left = 0
          Top = 0
          Width = 718
          Height = 9
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Color = clWhite
          ParentColor = False
          Transparent = False
          object RLLabel28: TRLLabel
            Left = 0
            Top = -4
            Width = 854
            Height = 14
            Caption = 
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' +
              '- - - - - - - - - - - - - - - - - - - - - - - - - -'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel29: TRLLabel
            Left = 683
            Top = -4
            Width = 28
            Height = 15
            Caption = '"'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Wingdings'
            Font.Style = []
            ParentFont = False
          end
        end
      end
    end
  end
  object pnlLogos: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 41
    Align = alTop
    ParentBackground = False
    TabOrder = 1
    object imgBancoReal: TImage
      Left = 8
      Top = 8
      Width = 193
      Height = 29
      Picture.Data = {
        07544269746D6170AECD0000424DAECD00000000000036000000280000005E01
        000032000000010018000000000078CD00000000000000000000000000000000
        0000B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890
        B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A8
        90B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0
        A890989068B0A890B0A890B0A890989068B0A890B0A890B0A890B0A890B0A890
        B0A890B0A890B0A890B0A890989068B0A890B0A890B0A890B0A890B0A890B0A8
        90B0A890B0A890B0A890B0A890B0A890989068B0A890B0A890B0A890B0A890B0
        A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890989068B0A890
        B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A8
        90B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0
        A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890989068B0A890
        B0A890B0A890989068B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A8
        90B0A890989068B0A890B0A890B0A890B0A890B0A890989068B0A890B0A890B0
        A890B0A890B0A890989068B0A890B0A890B0A890B0A890B0A890B0A890B0A890
        B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A890B0A8909890
        68B0A890B0A890B0A890B0A890D0D0D0FFFFFFE8E8E8E0E0E0E8E8E8FFFFFFFF
        FFFFE8E8E8E8E8E8E8E8E8FFFFFFFFFFFFFFFFFFE8E8E8E0E0E0E8E8E8FFFFFF
        FFFFFFE0E0E0E8E8E8F0F0F0FFFFFFFFFFFFE8E8E8E8E8E8E8E8E8FFFFFFFFFF
        FFF0F0F0E0E0E0E8E8E8FFFFFFF0F0F0E0E0E0E8E8E8FFFFFFFFFFFFFFFFFFE0
        E0E0E8E8E8FFFFFFFFFFFFFFFFFFD0D0D08080D88888D88888D88888D88080D8
        8080D88888D89098E09098E08888D88888D88080D89098E08888D88888D88080
        D88888D88888D88888D88888D88080D88888D88888D89098E08888D88080D888
        88D89098E08888D88080D88080D88888D88888D88888D88080D88080D88080D8
        8888D89098E08080D88888D88080D88888D89098E09098E08080D88080D88888
        D89098E08888D88080D88080D88888D89098E08888D88080D88888D88888D888
        88D89098E08888D88080D88888D89098E08888D88080D88888D89098E09098E0
        8888D88080D88888D89098E08888D88888D88080D88888D88888D89098E08888
        D88888D88080D88888D89098E09098E08888D88888D88888D88888D89098E088
        88D88888D88888D88888D88888D88888D88080D88888D88888D89098E08888D8
        8080D88888D88888D88888D88080D88080D88888D89098E08888D88080D88080
        D88080D88888D89098E08888D88888D88080D88888D89098E08888D88080D880
        80D88888D89098E08888D88080D88080D88888D88888D88888D88080D88080D8
        8888D88888D89098E08888D88080D88888D89098E09098E08888D88888D89098
        E09098E08888D88080D88888D89098E08888D88888D88080D8A0A0E000006860
        2858480860501860581860501860501858481060501860581860501860581858
        5018584810605818605818605818585018585018605018605018605818605018
        5848106050106050186058186050185850185850186058186050185850185850
        1060501860581860501858480860501058481060581858501860501058481060
        5818605018605018585010605018585010605018605018605818585010585018
        6050186058186050105850185850106050186050186058185848106050105848
        1060581860581858501058480860581860581860501858501058501860501860
        5018605018605818584810605018605018605818584810605018605018605018
        6058185850185848105850186058186050186058185850105850106058186058
        1860501858481060501860501860581860501858501058501060501860501858
        5018585010605018605818605018584810585010585010605818605018605018
        5850106050186050186050185850105850185850106050186050186058185850
        1058501058501060501860501058501858501060501860501860581858481058
        5010585010605018605018605018585010605818605818605018585010605018
        605018605018686028D0D0D0FFFFFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFF0F0
        F0F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0F0F0F0FFFFFFFFFFFFFFFFFFF0
        F0F0F0F0F0FFFFFFFFFFFFFFFFFFF0F0F0F0F0F0FFFFFFFFFFFFFFFFFFFFFFFF
        F0F0F0FFFFFFFFFFFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0FFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F82020E03030E03030E83028E82828D82828E030
        28E03030E83030E03030E83030E03028E03030E83030E83030E03028E03028E0
        2830E83030E83030E02828E02828E03030E82830E83030E02828E03028E03030
        E83030D82828E02828E82830E03030E03028E02828E82828E02828E03030E830
        30E82828E02828E02828E82828E83030E03030E02828E82828E02828E03030E0
        3028E83028E83028E03030E03030E83030E82828E02828E02830E03030E83030
        E03030E03028E82828E03030E03030E82828E83028E03030E03030E03030E030
        28E02828E03030E03030E83030E82828E02830E02830E03030E83030E83030E0
        2828E03028E83030E03030E02830E82830E02828E03030E03030E83030E83030
        E03030E03030E83030E83030E02828E02828E83030E83030E83030E02830E028
        30E03030E03030E02828E02828E02828E03030E82828E03028E83028E03028E0
        3030E83030E02828E02828E02828E82828E83030E03028E03028E03028E03030
        E03030E03028E83028E03028E03028E03030E02828E03028E03028E02830E030
        30E83030E03028E03028E02828E03030E03030E02828E82828E83030E03030E0
        2828E82828E03030E03030E03030D82828E02020E09098E00000605018605000
        5848005850005848005848005848006050005048006050005048006050005848
        0058500050480058500058480060500050480060500050480060500058480058
        5000584800585000584800605000584800585000584800605000504800605000
        5048006050005848005850005848005850005848005850005848005850005848
        0060500050480060500050480060500058480060500050480060500058480060
        5000504800605000504800605000584800585000584800585000604800605000
        5048006050006048006050005048006050005048006050005848005848005848
        0058500060480060500058480058500060480060500058400060500058480060
        5000584800605000584800605000585000605000585000605000584800605000
        5848005850005848005850005848006050005850006050005848006050005850
        0060500058480060500058500058500058480058500060480060500058500058
        4800604800605000585000605000585000605000604800605000585000605000
        5850006050005850006050005848006050005848005850005850005850006048
        0060500058480060500058500060500058480060500058500060500058480058
        4800685810D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E82830E82828E82828E83030F03030E82828
        E82828E82828F03030F02828F02828E82828E83030F02828E82828E82828E828
        30E82828E82828E82828E82830E82028E82828E83030F03030E82828E82828E8
        2828E82830E82828E82028E83028F02830E82828E82828E82828F02830F02828
        F02828E82828E82830E82828E82828E82828E82830F02828F02828E82828E828
        30E82828E82828E82830E82830E82828E82828E83028F02830E82828E82828E8
        2828E83030F02828E82028E82828E83030F02828E82828E82828E82830E82828
        E82828E82830E82830F02828F02828E83030F02830E82028E82828E83030F028
        30E82828E82828E82830E83030F02828E82828E82830E82830E82828E82828E8
        2830E82830E82828E82828E82830E82830E82828E82828E82830E82830E82828
        E82828E82830F02830F02828E82828E83030F02830E82828E82828F02830F030
        30F02828F02028E82830E82830E82828E82828E82830E82830E82828E82828E8
        2830E82830E82828E82828E83030F03030F02828E82828E83030F02830E82828
        E82828E82830E83030F02828E82828E82830F02830F02828E82828F02830E828
        30E82828E82828E82830E82830E01818E89098E0000068602858480058480058
        4808584808584808584800584800584808584800584808584800584800584808
        5848085848085848005848005848085848085848085848005848005848085848
        0058480858480058480058480058480858480858480058480858480058480858
        4800584800584808584800584808584800584808584800584808584800584800
        5848085848005848085848005848085848085848085848005848005848085848
        0858480058480058480058480058480858480058480858480058480058480858
        4808584800584800584808584808585008584800584808584808584800584808
        5848005848005848005848085848005848005848085848085848085848005848
        0058480058480858480858480858480058480858480058480858480058480058
        4808584800584808584800584800584808584800584808584800584808584808
        5848085848085848085848085848085848085848005848005848005848085848
        0858480858480858480058480058480858480058480858480858480858480858
        4808584808584808584808584800584808584808584800585008584808584808
        5848085848005848005848085848085848085848085848005848005048006058
        18D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82828E82828E82828E82828E82828E82828E82828E82828E8
        2830E82828E82828E82830E82830E82828E82828E82828E83028E82830E82828
        E83028E82830E82828E82828E82828E82828E82828E82828E82828E82828E828
        30E82828E82828E83028E82828E82828E83028E82830E82828E82828E82828E8
        2830E83030E82828E82828E83030E83028E82828E82828E82828E82830E82828
        E82828E82828E83030E83028E82828E82828E83028E82828E82828E82830E828
        28E82828E82830E82830E82828E83028E82828E82828E82828E82828E82828E8
        2828E82828E82828E82828E82828E82828E82830E82828E82828E82828E82828
        E83028E82828E82828E83028E82828E82828E83028E82828E82828E83028E828
        28E82828E83028E82828E82828E83028E82828E82828E83028E82828E82828E8
        3028E82828E82828E83028E82828E82828E82828E82828E82828E82828E83028
        E82830E83030E82828E82828E82828E82828E82828E82828E82828E82828E828
        28E82828E82828E82828E82828E82828E82828E82828E82828E82828E82828E8
        2828E82828E82828E82828E83028E83028E83028E82828E82828E83028E82828
        E82828F03028E83030E81818E88888D800007870386050005848086050085848
        1060500858480868500850400868580858480868500858480860500858480860
        5008584808605008584808685010584808685008584808604808584808604808
        5848086050085848086050086050106050085848086850085840086050085848
        0860480860480860500858480860500860480860480858480860500858400860
        5008584808605008605010605010584808605008604808605010584808605008
        5848006050085848086050086048086048086048086050085848086050086048
        0860500858480860501058480860500858481060500858480860500860480860
        5008584808604808604808605008584808605010584808605008584808605008
        5848086050105848086050085848086050085848086050085848086050085848
        0860480860500860500858480860500860501060500858480860500858480860
        5010584808604808604808604808605008605008584808605008605010605008
        5848086050085848086050106050086050085848086050085848086050085848
        0860500858480860500858480860480860500860500860500860500858480860
        5008584808605008584808605008584808605008584808584800686028D0D0D0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F82020E82828E82828E83030E83030E82828E82828E83030E83030E82828E828
        28E82830E83030E82828E82828E83030E83030E82828E82828E83030E83030E8
        2828E82828E83030E83030E82828E82828E82830E83030E82828E82828E83030
        E83030E82828E82828E83030E83030E82828E82828E82830E83030E83030E830
        28E83030E83030E83028E82828E82830E83030E82828E82828E83030E83030E8
        2828E83028E83030E83030E82828E82828E82830E83030E83028E82828E83030
        E83030E82828E82828E83030E83030E82828E82828E83030E83030E82828E828
        28E82830E83030E82828E82828E83030E83030E82828E82828E83030E83030E8
        2828E82828E83030E82830E82828E83028E83030E83030E82828E82828E83030
        E83030E82828E82828E83030E83030E82828E83028E83030E83030E82828E828
        28E83030E83030E82828E82828E83030E83030E82828E82828E83030E83030E8
        3030E82828E83030E83030E82828E82828E83030E83030E82828E82828E83030
        E83030E82828E82828E83030E83030E82828E82828E83030E83030E82828E828
        28E83030E83030E82828E82828E83030E82830E82828E83028E83030E82830E8
        2828F02828E82020E88888D80000686028605008605010584800685010584800
        6050106050105040006850105040006050106850105848005848005848006850
        1060501050400068501050400060501060501058480068501058480060501060
        5010685010584800605010605010584800605010504800605010685010584800
        6050105848006850105848006050105848006850106050105848006050105848
        0060501060501060501058480060501060501060501058480060501058480060
        5010685010584800605010584800685010605010504800584808685010605010
        5848006050105848006050106050105848006850105848006050106050106850
        1058480060501060501058480060501058480060501068501060501058480060
        5010584800605010584800605010584800605010605010584800685010584800
        6050106050105848006050106050106050105848006050085848086850106850
        0858480860500858480868501060500858480058480868501060500858480860
        5008584808605010605010605008584808605008584808605008584808605008
        5848086850106850085848086050085848086850106050085848086050085848
        08605008584808605008584808605010605008584800686028D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81820E8
        2830E82830E82830E83030E83030E82830E82830E83030E82830E83030E83030
        E82830E82830E83030E83030E82830E83030E82830E83030E83030E82830E828
        30E82830E83030E83030E83030E83030E83030E83030E82830E83030E82830E8
        3030E82830E82830E83030E82830E83030E83030E83030E82830E82830E83030
        E83030E82830E83030E83030E83030E83030E82830E83030E82830E82830E828
        30E83030E83030E83030E82830E83030E83030E82830E83030E83030E82830E8
        2830E83030E83030E83030E82830E82830E83030E82830E82830E83030E83030
        E83030E83030E82830E82830E82830E83030E82830E82830E83030E82830E830
        30E83030E83030E82830E82830E82830E82830E82830E82830E83030E83030E8
        2830E82830E82830E83030E82830E82830E83030E83030E82830E82830E82830
        E82830E83030E82830E82830E83030E82830E83030E83030E82830E82830E828
        30E83030E82830E82830E82830E83030E83030E82830E82830E82830E82830E8
        3030E83030E83030E83030E83030E82830E83030E82830E82830E83030E82830
        E82830E82830E82830E83030E83030E82830E82830E83030E82830E02830F028
        30F02020E89898E8000058501860480058480860500058480868580058480860
        5008605000605008504000605008584808605000584808685800584808605008
        6050006050085040006050085848086050005848086858005848086050085848
        0860500058480860500858480060500860500060500858480868580058480860
        5000584808605000584808685800584808605008605000605008584800605008
        5848086050085848006050085848086050086050006050085848006050085848
        0860500058480868500058480860500860500060480058480860500858480060
        5008605000605008584808685000584808605000584808605008584808605000
        5848086050086050006050085848006050085848086050085848006050086050
        0060500860500060500858480060500858480860500058480860500058480860
        5008605000605008584808605008584800605008605000605008584808605008
        5848086048005848086050085848006050085848086050086050086050085848
        0060500858480860500858480860500860500860500860500860500858480060
        5008584808584808584808605000584808605008605008605008584808605008
        584808605008605000605008584808605000685810D0D0D0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E830
        30E82828E82828E82828E83030E82828E82828E83030E82828E82828E83030E8
        2830E82828E82828E82828E82828E83030E82828E82828E83030E83030E82828
        E82828E82828E83030F02828E82828E82828F03030E82828E82828E82828E830
        30E82828E82828E83030E83030E82828E82828E83030E83030E82828E82828E8
        2830E83030E82828E82828E82828F03030E82828E82828E82830E83030E82828
        E82828E82828E83030F02828E82828E82830F02828E82828E82830E83030E828
        28E82828E82828E82830E83030F02828E82828E83030E83030E82828E82828E8
        2828E83030E82830E82828E82828E83030E82828E82828E83030E82828E82828
        E82828E82830E83030E82828E82828E83030E83030E82828E82828E83030E830
        30E82828E82828E83030E83030F02828E82828E83030F03030E82828E82828E8
        2828E83030E82828E82828E83030E82828E82828E83030E83030E83030E82828
        E82828E83030E83030E82828E82828E83030F03030E82828E82828E82828E828
        28E82828E82828E82828E83030F02828E82828E83030F02828E82828E82828E8
        3030E83030E82828E82828E83030E82830F02828E82828E02830E82830F01820
        E09098E000006058186048086850085848006050085848006850086050085848
        0060500850400060500860500858480058480858480060500860500858480060
        5008504000605008685008584800605008584800685008605008605008584800
        6850086050085848006050085848006050085848085848006850085848006050
        0858480068500858480060500860500858480060500858480060500860500860
        5008584800605008605008605008584800605008584800605008604808584800
        6850085848006050086050085848005848086050086050085848006050085848
        0060500860480858480060500858480068500860500860480858480068500860
        5008584800605008584800605008605008605008584800605008584800605008
        5848006050085848006050086048085848006050085848006850086050085848
        0060500868500860500858480060500858480860500858480858480860480858
        4808605008605008584800584808605008605008584808605008584808605008
        6050086050085848086050085848086050085848086050085848086050085848
        0858480860500858480860500860500858480860500858480860500858480860
        5008584808605008604808584800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E83030E83030
        F02828F03030E83030E83030F02828F02830E83030E82828F02830E83030E830
        30E82828E83028E82830E82830E82828E82828F02830E83030E83030F02828E8
        3030E82830E82830E82828E82830E82830E82828E83030F03030E83030E83030
        F02828F02830E82830E82830E82828E83030E83030E82828E82828E83030E828
        30E82830E82828E82830E82830E82828E83030E83030E83030E82828F02830E8
        3030E82830E82830E82828E83030E83030E82828E82830E82830E83030E82828
        F02830E83030E83030E82828E82828E83030E82830E82828E82828E83030E830
        30E83030E82828F03030E83030E83028F02828F02830E83030E82828F02828E8
        3030E83030E82828E83028E82830E82830E82828E82828F02830E83030E82828
        F02828E83030E83030E82828E82828E82830E82830E83028E82828F03030E830
        30E83028F02828F02830E83030E82828F02830E83030E83030E82828E82828E8
        3030E82830E82828E82828E82830E82830E83028E82828F03030E83030E82828
        F02828E83030E82830E82828E83028E83030E83030E82828E83028F02830E828
        30E82828F02828E83030E83030E82828E82828E82830E82830E81820E89898E8
        0000605818604800584808685800584808605000584808605008504008605008
        6050006050085848086858006050086050005848085850085848006050086050
        0060500858480868580058480860580058480858500058480868580058480860
        5008605000605000584808605008584808605000584808605008584808605008
        5848086850005848085850005848086050086050006050085848086050085850
        0060500858480860500858480060500860500060500858480868500058480860
        5000584808605008584800605000584808605008605000605008604800605008
        5848006050085848086050005848086050085848086050005848086050085848
        0060500860500060500858480860500860500060500858480060500860480860
        5008604808605008584808605000584800605008584808605008584800605008
        5848086050086050006050086048086050085848086048085848086050085848
        0860500058500860500858480860500858480860500858500860500858480860
        5008585000605000585008605008585008605008585008585008584808605008
        5848086048085848086050086048006050085848086050086050086050085848
        08605008584808584800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81820E82828E82828E83030E82828E8
        2828E82828E83030E83030E82828E82828E82828E83030F02828E82828E82828
        F03030E82828E82828E82828E83030E82828E82828E83030E82828E82828E828
        28E83030F02828E82828E82828E82828E83030E82828E82828E83030E83030E8
        2828E82828E82830E83030E83030E82828E82828E83030F02828E82828E83030
        F02828E82828E82828E83030E83030E82828E82828E82830E83030F02828E828
        28E82830F03030F02828E82828E83030F03030E82828E82828E82830E83030F0
        2828E82828E82828E83030F02828E82828E83030F02828E82828E82828E83030
        E83030E82828E82828E83030E83030E82828E82828E82830E83030F02828E828
        28E83030E83030E82828E82828E82828E83030E82828E82828E83030E82828E8
        2828E82828E82828E82828E82828E82828E83030F03030E82828E82828E83030
        E83030E82828E82828E83030E83030E83030E82828E82828E83030F02828E828
        28E83030F02828E82828E82828E83030F03030E82828E82828E83030E82830F0
        2828E82828E83030F03030F02828E82828E83030F03030E82828E82828E83030
        E82830F02828E82828E82828E83030E82828E82828E82020E89098E000007870
        3858480060480858480068500858480060480860500850480860500858480060
        5000604800584808584808584800684808585008585000605000584808605000
        6050005848006850085848005848005048006850085848006050086050085848
        0060500058500860500868480858480058480858480868480858480860480858
        4800685008504800585008585000584808605008604808605008584800585008
        5848006050085848006050085848006050085048085848085048085848006850
        0860500858480058480868480860500858480060500858480060500058480058
        5008584800584808584808605008604808584800605008605008584800605008
        5848006050086048086050085848006050085848006050086048086048085848
        0860500850480858480060500058480860500860500858480060500860480860
        5000584800605000604800605008604808604800584800584808605008585000
        5848085848086050086048085848006050005848006050086048086050085848
        0060500058500860500858480058500050480858500860480858480860480860
        4800605008604808604808605008584808605008584808605008584808605008
        584808504000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E82830E83030E02828E828
        28E82830E83030E83028E82828E83030E83030E82828E82828E82830E82830E8
        2828E83028E82828E83030E83028E82828E82830E83030E82828E82828E83030
        E83030E82828E83028E82830E82830E82828E82828E82830E83030E83028E828
        28E83030E82830E82830E82828E83028E82830E82828E82828E83030E83030E8
        2828E83028E82830E82830E82828E82828E83030E83030E82828E82828E83030
        E82830E82828E82828E82830E82830E83028E82828E83030E83030E82828E828
        28E83028E82830E82828E83028E83030E82828E82828E82828E82830E82830E8
        2828E82828E82830E83030E83028E82828E83030E83030E82828E82828E82830
        E82830E83028E83028E82828E83030E83028E82828E82830E83028E82828E828
        28E83028E82828E83028E83028E82830E82830E82828E82828E82830E83030E8
        3028E82828E83030E82830E82830E82828E83028E82830E82828E83028E83030
        E82828E83028E83028E82830E82830E82828E82828E83030E83030E82828E830
        28E83030E82830E82828E82828E82830E82830E83028E82828E83030E83030E8
        2828E82828E83028E82830E02828F02828F02020E88888D80000686028685008
        6050105848006050106048005850106858085040006858085840006858086050
        0868500058480060500060500868581050480068580850400068580860500860
        4800605008604800605008685808605010584800605010685808504000685808
        5848006858005850086048086050106048006050086050005850086050085850
        1068580858480068580058480068580860500868580858480068580860500868
        5810584800685810584800685808605008685000605008685000605010685808
        5848006050086050106858105048006858105048006050086050006050006050
        0068500060500868581060501060500060501068581058480068581058480068
        5810605010685810584800605010584800685808584800605008584800605008
        6050086048006050086050006050086858105848006858086050106858006048
        0068580058480068580860500860500060500060500060500860500858480060
        5000605008605008584808685808604800685808605010605008584808605008
        5848006850085848006050085848086858086050006050006050086050006050
        0868500858480068500858480860500858480868500858480868581060500858
        4800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E83030F02830E83030E83030F03030E82830
        E82830E82830E83030E82830E82830E83030E83030F03030E82830E83030F030
        30E83030E82830E82830E83030E82830E83030E83030E83030F02830E83030E8
        3030F03030E83030E82830E83030F03030E82830E82830E82830E83030E82830
        E83030E83030E83030E83030E83030E83030E83030F02830E83030E83030F030
        30E83030E82830E83030E83030E82830E82830E83030E83030F02830E83030E8
        3030E83030F03030E82830E83030E83030E82830E82830E83030E83030F03030
        E82830E83030F03030F02830E83030E83030F03030E82830E82830E83030F030
        30E83030E82830E83030E83030F02830E82830E83030E83030F02830E83030E8
        3030F03030E83030E82830E83030E83030E82830E83030E83030E83030F03030
        E83030E83030F03030E83030E82830E83030F03030E83030E82830E83030E830
        30F02830E82830E83030E83030F03030E82830E83030F03030F02830E83030E8
        3030F03030E83030E82830E83030F03030F02830E82830E83030F03030F02830
        E83030E83030F03030F02830E83030E83030F03030F02830E82830E83030E830
        30F03030E82830E83030F02830E82020E89098E0000058501858480058480860
        5000584808585000584808504800504000504000604800504000504000604800
        6048005040005040085848085848005848086050005848085040085040004840
        0050480050400058480058480860500058480858480050480048400048400050
        4000504800585000584808584808484000484000504800584808584808584800
        5848005040005048004840004840005040005040005848005848085848086050
        0058480858480058480050400050380050380050400048400050480058480060
        5000584808584808685000584808604800504800504000503800483800484000
        4840005848085848085848005848085848085848005848086850005848085848
        0858480858500058480858480048400048400048400058480858480050480058
        5000484000504000504000584008584800584800584000584000584000504000
        5040005040005040005040005040005040005040005848085048005040004840
        0050480058480058480860480858480058480858480858480850400050400050
        4800604800584800585000584800504000504800484000504000504000504000
        5040005040005040005848086050005848085848005848085848085048006058
        18D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82828E82828E02828E82828E02828E82828E82828E82828E0
        2828E82828E02828E82830F03028E82828E02828F02828E82828E02830E82828
        E82828E02828E82828E82828E82828E02828E82828E02828F02828E82828E028
        30E82828E82828E82828E02828E82828E82828E02828E82828E82828E82828E8
        3030E83030E02828E82828F03028E82828E02828F02828E82828E02830E82828
        E82828E82828E83030E02828E82828F02828E82828E02828F02828E83028E828
        28E02828F03030E82828E82828E02828E82828E82828E82828E02828E82828F0
        2828E02828E02828F02828E82828E02828E83030E82828E82828E02828E82828
        E02828E02828E82828E02828E82828E82828E82828E02828E82828E82828E028
        28E82828E02828E02828E82828E82828E02828E02828E82828E02828E82828E8
        2828E02828E82828E82828E82828E02828E82828E02828E02828E82828E02828
        E83030E83030E82828E02828E82828F02828E02828E02828F02828E82828E028
        28E82828E82828E82828E02828E02828E82828F02828E02828E02828E82828E8
        2828E02828E02828F02828E82828E02828E02828E82828E82828E82828E02828
        E82828E82828E82828E81820E09098E000006058186850086048086050006050
        1068500058480068602878703888805088805088805078703888805088805088
        8050686028504800584000685808584800605008686028888050888050888050
        7870385850006050106050006050085848086860288880508880508880506858
        1058500058480868581088805088805058480860480060500060500850480888
        8050787038888050888050888050787038605008604800685008584800605000
        504000605010989068B0A890B0A890B0A8908880585048005848006050086050
        08605008584800605008503800686028B0A890B0A890B0A890B0A89088805058
        4000585008604800605010605008584800685008584800685808605008605008
        5848006050085848108880507870388880506050105850085048005850107870
        3888805088805068602850400860500868581088805088805088805088805088
        8050888050888050888050888050686028584808686028888050787038605010
        5848086850006048006050086050006050005848086860288880507870385848
        0858480858480868581088805088805088805088805088805088805088805088
        8050787038605000604808605008584808685008605008584800686028D0D0D0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F82020E82830E82828E82830E83030E82828E82828E82830E83030E83030E828
        28E83030E83030F02828E82828E82830E83030E82828E83030E83030E83030E8
        3030E82828E82830E83030E82828E83028E83030F03030F02828E83030E83030
        E83030E82828E82828E82830E83030E82830E82828E83030E83030F02830E828
        30E83030E83030F02828E83028E83030F03030E83028E83030E83030F03030F0
        2828E82830E83030E83030F02828E83028E83030E83030F02828E82828E83030
        E83030E82830E82828E83030E83030F02828E82828E83030E83030F02828E830
        28E83030F03030E82828E82828E82830E83030E82828E82828E82830E83030E8
        3030E82828E83030E83030F02828E82828E83030E83030E83028E83028E83030
        E83030E83028E82830E83030E83030E82828F02828E83030E83030E83028E830
        28E83030F03030E83028E82828E82830E83030E83030E82828E83030E83030F0
        2830E82828E83030E83030E82828E83030E83030F03030E83028E83028E83030
        E83030E83028E82828E83030E83030F02828E82828E83030F02830E82828E830
        28E83030E83030E83028E82828E83030E83030F02828E82828E83030E82830E8
        2828E82830F02020E8A0A0E80000605818584800584808584800584808605010
        504000989068F0F0E8E8E8D8E8E8E0E8E8E0E8E8E0E8E8E0E8E8E0E8E8E0E8E8
        E0989068483800504800584808604800887858F8F8F0E8E8E0E8E8E0F0F0E048
        3800604800605008604800504008D0D0D0E8E8D8E8E8E0F0F0E8808018504000
        504000989068F8F8F0E8E8D8504008585000584800584800787038F8F8E8E8E8
        E0E8E8E0F0E8E0F0F0E0E8E8D8504808504800585000604800483800787038D8
        D8B0F0F0F0F8F8F0F8F8F0F8F8F0E8E8E0887858483800585000504808604800
        504000504800989068D0D0D0F8F8F0F8F8F0F8F8F0F8F8E8E8E8E08880586048
        0060500058480058480868500058480858480058480858480858480858480858
        4800685810FFFFFFE8E8E0E8E8D8686028584800504800686028F0F0E8E8E8E8
        E8E8D8787038504800584808888050F8F8F0E8E8E0E8E8D8E8E8E0E8E8E0E8E8
        E0E8E8E0E8E8E0F0E8E0C8B898504800989068F8F8F0D8D8B068602850480850
        4800504808504800584800584800605018B0A890F0F0E8D0D0D0584808584808
        584800686028F8F8F0E8E8E0F0E8E0E8E8E0E8E8D8E8E8E0E8E8E0F0F0E8D0D0
        D0483800584808584808605000584808584808584800685810D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E8
        2828E82828E02828E82828E82828E82828E02828E82828E82828E82828E02828
        E83030E02830E03028F03028E83028E83028F02828F02828E82830E02028F020
        28F02028E82028E82028F02828F02830E02828D83030D83030D82828E82828F0
        2828E82830E02830E02830E03028E83028E02828E82828E02830F02828F02028
        E02030E02030E02030E02828E82828E02830D82028E02028E02830E03028F028
        28E82828E03030E02828E82828F02830E82830D82830D82828D82820F03028F0
        3028E83028E03028E83030E02030E02030E82030E02030E02028F02828E83030
        D83030D82828E02828F03030E83030E82828E02828E03028E03028E82828F028
        28E02830E02828E82828E02830D82830E02830E82830E82828F02828E02830E0
        2828E82028F02828F03030D83030D83028E03028E02030E02030E02828E02828
        E02030E02020D82828E83028E83028E82828E02828D82830E02830E82030E028
        30D82828E02828E82828E82828F02828E02828E02828F02828F02828E82030E8
        2030E02030E02030E82028E02828E83028F03028E02828E82028E82028E02028
        E82828E82828E82828E82828E82828E02828E82828F02828E02828E02828E828
        28F01820E09898E80000686028605000605008605000605010605008584800B0
        A890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0
        C8B898585008504008685000605818FFFFFFFFFFFFFFFFFFFFFFFF5040006048
        08605800584800605018F8F8E8FFFFFFFFFFFFFFFFFF584808584800504808B0
        A890FFFFFFF8F8F0504010605800604808584808B0A890FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF8F8F0605010504808605800504008888058E8E8D8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E068602858480050480068500850400898
        9068F8F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8D8503800605000
        6050006050085848006050085848006858086050086050085848086050006858
        10FFFFFFFFFFFFF0F0F0686028605000584810888058FFFFFFFFFFFFF8F0F068
        6028504800605010888058FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE0E0E0504800888050FFFFFFF8F0F08880585040006050005048
        10605008605008605008605018E8E8D8FFFFFFE0E0E048380068500058480068
        6028FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E0504000
        584808605008584808605008605008584800686028D0D0D0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E830
        30E83030E82828E83030E83030E83030E82828E82830E83030E82828E82828E8
        3028F03830E82828E02828E02830E82830E82820F02020E82828E02828D82020
        D82020D82828E02028E82020E82828F03028F02830F02028E82828E83030E830
        30E82830E82828E82828E83030E82830E83028E83030E83030E83028F03028F0
        3030F03030E82828E83030E83030E83028F03028F03028E83030E83030E82828
        E82828F03030F02830E82830E82828F02830F03038E82830E82828E82830E830
        30F02028E82030E82830F03030F03028F03028E83030E83030E82828E82830F0
        3030F03030E82830E02830E83030E83030E82830E82828E82830E83030E82828
        F02828F03028F03030F02828F02828E82830E02830E83028F02830F02830E828
        30E82828E02830E82830E82830E82830E82828E83028E83830E83028E83028E8
        3030F02830E82830E82828E82830E83030E82830E82830E82830E83030E83028
        E82830E82830E83028F02828E82830E82830E82830E82828E83030E83830E838
        30E83028E82828F03030F02830E82030E82828E83030E83030E83028E82828E8
        3030E83030E82828E82828E83030E83030F02828E82828E03030F02830E82020
        E89098E00000787038504000584808605000584808584810504000989068FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0
        A890483800584800484810E8E8D8FFFFFFFFFFFFFFFFFF483800584808585000
        504000686028FFFFFFFFFFFFFFFFFFFFFFFF483800585000484000989068FFFF
        FFF8F8F0483800585000584800504808F8F8E8FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF8F8E8504808504800504800787038F8F8E8FFFFFFFFFFFFFFFFFFE8E8E0
        F0F0E8FFFFFFFFFFFFFFFFFFD8D8B0504000584800584808686028E8E8D8FFFF
        FFFFFFFFFFFFFFF0F0E8E8E8E8FFFFFFFFFFFFF0F0F088805050400058480058
        4808584800584808685000584808584808584808585008584800685010FFFFFF
        FFFFFFE8E8E8686028584000584808888058FFFFFFFFFFFFF0F0E86050105048
        00584808888058FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFE8E8D8483800686028FFFFFFFFFFFFB0A890503800584800605008584800
        584008584008787038FFFFFFFFFFFFD0D0D0483800604800604800686028FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8D848380058500058
        4808584800584808584808584800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E02828
        E82828E02828E82828E82828E82828E02828E82828E02828E82830F02028E820
        28E02020F02020E82020D82828D83838E08080D89898E8A0A0E8A0A0E8A0A0E8
        A0A0E88888D88080D83838E02020D82020D82020E82820F02828E82828E82828
        E82828E82828E82828E02828F02828E83030E83028E02028E02028E82028F018
        20E82020F02020F01820E82028E02028E02828E02830E02830E02828E82828E8
        2028E02028E02028E82028E82828F02828E82830E82830E02030E02028E82028
        E02028E82028F02028E82028E02028E02030E02028E82028F02020F02828E828
        30D82830E02028E02028E82828F02020F02828F02830E02830D82830D82030E0
        2828E82820F02028E82828E02820E82820F02028E82030E82828E83028F02820
        F02020E82028E82028F02028E02020E82028F02028E82028E82828F02820E028
        28E02028E02028E02030E02028E82020F02830E82830E02830E02028E82820F0
        2828E82830E02828E82028E82028E02828E82028F02028E82020E82820E83028
        E03028E02028E82028F02020F02028F02028E82020E82028F02828E82828E028
        28E02828E82828F02828E82828E02828E82828E82828E82828E81820E08080D8
        0000787038605000604808605000605010605008584800B0A890FFFFFFFFFFFF
        FFFFFFFFFFFF888058989068888058D8D8B0FFFFFFFFFFFFFFFFFFF8F8F05040
        08685800504808B0A890FFFFFFFFFFFFFFFFFF48380050380058480048400098
        9068FFFFFFFFFFFFFFFFFFFFFFFF483800605800504800B0A890FFFFFFF8F8F0
        484810605800584800888058FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8
        E8605018584808585010C8B898FFFFFFFFFFFFFFFFFFB0A890686028686028B0
        A890FFFFFFFFFFFFF8F8F0503800604808605018B0A890FFFFFFFFFFFFFFFFFF
        989068686028686028888058FFFFFFFFFFFFD0D0D05048105850006850085848
        00685808584800685808605008605008584808605000685010FFFFFFFFFFFFF0
        F0E8686028605000605010888058FFFFFFFFFFFFF0F0E8605008504800605010
        888058FFFFFFFFFFFFF0F0F09890689890689890689890689890689890688880
        58584800686028FFFFFFFFFFFFD8D8B048380058480050400060480050400860
        5010989068FFFFFFFFFFFFE0E0E0483800685008584000787038FFFFFFFFFFFF
        FFFFFFE0E0E0B0A890B0A890B0A890B0A8909890685848005848086050085848
        08685008605008584800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F82020F02830E82828E82830E83030E8
        2828E82828E82830E83030E83030E82828E83030E83030E82028E82828E83838
        E08080D8A0A0E8C8C8F0E0E0F8F0F0F8F0F0F8F0F0F8FFFFFFFFFFFFF0F8F8F0
        F0F8E8E8F8E0E0F8C0C0F89098E05858B83030D82028E82828F02828E83030E8
        2828E83030E83030E83030F02830E82828E82828E03030D84868C86870C08080
        D88080D85858B83838E02028E02028F02028E82828E83028F03028E03838E058
        58B83030D82820E02828E82830D82020D82828F03030E83030D83030D84038B8
        4038B83030D83030D83030D83030D84038B84038B84038B83030D82028E82828
        E82828F02830E04038B84038B83838E02820E02830E83030E82828E03838E058
        58B83838E82028E83838E03838E02830E02830F03030E04038B83038D83838E0
        4038B83038D83038D83838E04038B83030D83030D84038B83838E02828F02830
        E82830E82820D83838E05858B83838E02020E82020E83838E03038D82020E020
        28E82828E83030F02828E82820E03030D83838E04868C83838E02828E02830E8
        2830E83030D84038B83030D83030D83838E03038D83030D82828E82828E83030
        E83030F02828E82830E83030E82830E82828E82830F02028E88888D800006860
        28584800584808584800584808605010504000989068FFFFFFF0F0F0FFFFFFFF
        FFFF483800584808584808605818C8B898FFFFFFFFFFFFFFFFFF787038584000
        484000686028FFFFFFFFFFFFFFFFFF888050888058888050888050D0D0D0FFFF
        FFF0F0F0FFFFFFFFFFFF483800605000484000989068FFFFFFF8F8E850400858
        5000584000B0C0A8FFFFFFFFFFFFFFFFFFF8F8F0FFFFFFFFFFFFF8F8E8504808
        584000585010FFFFFFFFFFFFFFFFFFFFFFFF504008504800504000605018F0E8
        E0FFFFFFFFFFFF483800584800504810F0F0E0FFFFFFFFFFFFE8E8E848400050
        4800504000585018C8B898FFFFFFFFFFFF787038484000584808585008584808
        584800584808584808584808584808584800685810FFFFFFFFFFFFF0F0F06860
        28584000584808888058FFFFFFFFFFFFE8E8E8504008585000584808888058FF
        FFFFFFFFFFE8E8D8585018584808584808604808584808584808584808584000
        686028FFFFFFFFFFFFE8E8E0888058888050888058888050888050888058E8E8
        D8FFFFFFFFFFFFE0E0E0483800584808584800686028FFFFFFFFFFFFFFFFFFC8
        B898504808605018605018585018605018584800604808584808605000584808
        584808504000685810D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E02828E82828E82828E828
        28E02828E82828E82828E82828E02828E82828E82820D86870C0E0E0F8E8E8E8
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF0F0F8E0E0F8C0C0F86870C02020D82828E82828E82828E828
        28E03028E82828E02830F02020E85858B8C8C8F0E8E8E8F0F0F0F0F0F8E0E0F8
        E8E8F8C8C8F0A0A0E83838E02028F02820F03028E08080D8E0E0F8F0F0F0C8C8
        F08080D85858B89098E0A0A0E85858B83838E0A0A0E8E0E0F8D0D0D0C8C8F0C0
        C0F88080D88080D8C8C8F0E0E0F8D0D0D0D0D0D08080D82020F03028E82820E0
        6870C0C8C8F0E0E0E0C8C8F09098E03838E03030E88080D8C8C8F0F0F0F09098
        E05858B8A0A0E8E0E0F88888D83030D85858B8A0A0E8C8C8F0D0D0D0C8C8F0C8
        C8F08080D8A0A0E0E8E8E8C8C8F0C8C8F0C8C8F08080D82020E82820E03838E0
        8080D8C8C8F0F8F8E8C0C0F89098E05858B88888D8C8C8F08888D83838E03030
        D82828E03030D86870C0C0C0F8E0E0F8E8E8F8E0E0F89098E03838E02830D880
        80D8C8C8F0E0E0F8E0E0F8D0D0D0C0C0F86870C02828E82828E82828E82828E0
        2828E82828F02828E02828E02828E82828F01820E09098E00000585018685008
        605008605000605010605008584800B0A890FFFFFFFFFFFFFFFFFFFFFFFF4838
        00685000584000584800787038FFFFFFFFFFFFFFFFFF88805060500058480858
        4800F8F8F0FFFFFFFFFFFFE8E8E8E8E8E8E8E8E8F0E8E0FFFFFFFFFFFFFFFFFF
        FFFFFFF8F8E8503800605000504808B0A890FFFFFFF8F8F05040105850005848
        08FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8E860501050480868
        6028FFFFFFFFFFFFFFFFFFFFFFFF483800605000604800604808D0D0D0FFFFFF
        FFFFFF483800604800686028FFFFFFFFFFFFFFFFFFF0F0F04838006050006048
        00605008888058FFFFFFFFFFFF98906850480060500858480868580858480068
        5808605008605008584808605000685010FFFFFFFFFFFFF0F0F0686028605000
        605010888058FFFFFFFFFFFFE8E8E8504808504800685810888058FFFFFFFFFF
        FFE8E8E0585018605000604800604800604808584800585008605008685810FF
        FFFFFFFFFFFFFFFFF0F0E8E8E8E0E8E8E8E8E8E8E8E8E0E8E8E8FFFFFFFFFFFF
        FFFFFFE0E0E0483800685008584000686028FFFFFFFFFFFFFFFFFFC8B8984838
        0060500058480860500860500060500858480860500858480868500860500858
        4800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E83030E83030E82828E83030E83030E83030
        E82828E82830E83030E82828E83838E08888D8E0E0F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFC8C8F05858B82828D82828F02830E83030E82828
        E83030E83030E82828E88080D8FFFFFFF0F8F8C0C0F86870C03838E86870C0C0
        C0F8E8F8F89098E02028E82830E85858B8E0E0F8FFFFFFC0C0F8A0A0E8C0C0F8
        C0C0F8F0F0F8F0F0F89098E03038E89098E0FFFFFFFFFFFFC0C0F85858B83838
        E83838E08888D8E8E8F8FFFFFFC0C0F83838E03028F02820E83028E09898E8FF
        FFFFFFFFFFE0E0F8C8C8F08080D86870C0E8E8F8FFFFFFFFFFFFE0E0F8C8C8F0
        FFFFFFFFFFFFE0E0F89098E03838E83838E8C0C0F8FFFFFFC8C8F06870C03838
        E08080D8E0E0F8FFFFFFE8E8F89098E03838E82828E05858B8C0C0F8F0F0F8F0
        F0F8C8C8F0C0C0F8C0C0F8C0C0F8E0E0F8FFFFFFE0E0F8C0C0F84868C83030E0
        8080D8E0E0F8FFFFFFFFFFFFE0E0F8C0C0F8E0E0F8C0C0F85858B83838E06870
        C0C8C8F0FFFFFFA0A0E83838E03030F03030E83030E82830E82830E83030E830
        30F02828E82830E03030F02830E81820E89898E8000058501858480058480860
        5000584808584810504000989068FFFFFFFFFFFFFFFFFFFFFFFF483800605010
        684808584808605018FFFFFFFFFFFFF0F8F8888050504000584808504000D8D8
        B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8
        B898483800585000484000989068FFFFFFF8F8F0483800604800504008FFFFFF
        FFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFF8F8F0504808504000787038FFFF
        FFFFFFFFFFFFFFF0F0F0483800585000584800605008D0D0D0FFFFFFFFFFFF48
        3800584800686028FFFFFFF0F0F0FFFFFFF8F0F0483800605000584800584800
        787038FFFFFFF0F8F8B0A8904838005848086048005848086850005848085848
        08584808585000584800685810FFFFFFFFFFFFF0F0E868602858400058400898
        9068FFFFFFFFFFFFE8E8E8504000504008584808888058FFFFFFFFFFFFE8E8E0
        585018584800584800605008584808584808584800584800686028F0F0E8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0
        D0D0483800604800604800686028FFFFFFFFFFFFFFFFFFB0A890483800604800
        6048085848086050005848086050005848085848005848085848085040006860
        28D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82828E82828E02828E82828E02828E82828E82828E82828E8
        3028E02828E01820E05858B8F0F0F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFC8C8F05858B82020D82830E02830E02828F02828E8
        3030E82028E08080D8FFFFFFA0A0E83838E02828E82020D82820E83838E0A0A0
        E0C0C0F81818E82828E08080D8FFFFFFC0C0F83030D83030D83838E09098E0FF
        FFFFC0C0F83838E02020E88080D8F0F8F8FFFFFFA0A0E82020D82020E82020E8
        3838E0C0C0F8FFFFFFA0A0E82020D82828E02820F03838E8C0C0F8FFFFFFA0A0
        E85858B84868C83838E09098E0FFFFFFFFFFFFC0C0F85858B8A0A0E0FFFFFFFF
        FFFFA0A0E03838E03030E02820D89098E0FFFFFFA0A0E83030D81820E05858B8
        C8C8F0FFFFFFC8C8F05858B82020E03838E0C0C0F8FFFFFFFFFFFFA0A0E03838
        E03838E04038B88080D8E0E0F8FFFFFF9098E03838E02830E05858B8C8C8F0FF
        FFFFFFFFFFC0C0F85858B83038E05858B88888D85858B82020E02828D8A0A0E8
        FFFFFF8888D81820E02028E82828E02828E02828E82828F02828E82828E02828
        E82828E82828E82828E81820E09898E800006860286050086050086050006050
        10605008584800B0A890FFFFFFFFFFFFFFFFFFFFFFFF48380068500860480850
        4800686028FFFFFFFFFFFFFFFFFF686028605000504810584800B0A890FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A8905840
        00605800504800B0A890FFFFFFF8F8F0484810604800504810FFFFFFFFFFFFFF
        FFFFD0D0D0FFFFFFFFFFFFFFFFFFF8F8E8605018504808888058FFFFFFFFFFFF
        FFFFFFFFFFFF503800605008585008605008888050B0A8909890685848006048
        00887858FFFFFFFFFFFFFFFFFFF8F8F0503800685008585008604800686028FF
        FFFFFFFFFFC8B898504000605008604800685808584800685808605008605008
        585000604808685810FFFFFFFFFFFFF0F0E8686028584800504010C8B898FFFF
        FFFFFFFFE8E8E8584000584808685808989068FFFFFFFFFFFFE8E8E858501860
        5008605000605800604808605008605008605008685010D0D0D0FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E04838
        00685000584000686028FFFFFFFFFFFFFFFFFFC8B89848380060500858480060
        5000584808605008584808605008584808685808605008584800686028D0D0D0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F82020E82830E82828E82830E83030E82828E82830E82830F03030F03030E028
        28E83838E8A0A0E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF0F0F8E8E8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC8C8F05858B82828E02828F03030E83030E82830E020
        20E08080D8E0E0F85858B82828E02828F03030F02828E82020E08080D89898E8
        2020F02828E88888D8FFFFFFA0A0E82028E02028E82820E88080D8FFFFFFA0A0
        E82828D82020E88080D8F0F8F8FFFFFFA0A0E82020E03030F03028E83838E8C8
        C8F0FFFFFFA0A0E82020E82828E82820E85858B8C8C8F0E0E0F88080D83028E0
        2820E02828E09898E8FFFFFFFFFFFF9098E02020D89098E0FFFFFFFFFFFFA0A0
        E82028E02828E82828E09098E0FFFFFFA0A0E83838E02828E85858B8C8C8F0FF
        FFFFE0E0F85858B82020E88080D8E8E8F8FFFFFFF0F8F88080D82020E82828E0
        2828D83838E0C0C0F8E8F0F88080D82828E02020E89098E0FFFFFFFFFFFFC8C8
        F05858B83028E82028F03030E03838E03838E82028F03030E8A0A0E8FFFFFF90
        98E02820E82830E83030E83030E83030E83030F02830E82830E83030E83030E8
        2828E82830F02028E89098E00000787038584000584808584800584808605010
        504000989068FFFFFFF8F8F0FFFFFFFFFFFF201800483800483800484810D0D0
        D0FFFFFFFFFFFFFFFFFF584008604800584808504000787038FFFFFFFFFFFFFF
        FFFF686028888050705048FFFFFFFFFFFFFFFFFFFFFFFF686028584000605000
        484000989068FFFFFFF8F8E8504008504000888058FFFFFFFFFFFFF8F8E09890
        68FFFFFFFFFFFFFFFFFFF8F8E8504810504800888058FFFFFFF8F8F0FFFFFFFF
        FFFF483800585008584808605000584808585008585008584008584800887858
        FFFFFFFFFFFFFFFFFFE8E8E8483800605008584808504000585018FFFFFFF0F8
        F8C8B89848380058480868500058480858480058480858480858480858500858
        4008685810FFFFFFFFFFFFF0F0F0705048585018B0A890F8F8F0FFFFFFFFFFFF
        F8F8F0483800584808584808888058FFFFFFFFFFFFE8E8D84848104838004838
        00483800483800584000584800504800685010B0A890FFFFFFFFFFFFE8E8E888
        7858787038888058F8F8E8F0F0E0FFFFFFFFFFFFFFFFFFE0E0E0483800584800
        584800686028FFFFFFFFFFFFFFFFFFC8B8984838005848086048005848005848
        08584808584808584808685008584808584808584800686028D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E8
        2828E82828E02828E82828E82828E82828E02828E82828E03028E83028E08080
        D8E8E8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFE0E0F8C0C0F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF0F8F8A0A0E83838E02020F02828E82828E82830E82028E86870
        C0A0A0E82028E02030F02828E83028E82828F01820E83838E86870C02828D820
        28E05858B8E8E8F8C0C0F82020D81820E02020D85858B8E8F0F8A0A0E82820E0
        2020E86870C0F0F8F8FFFFFFA0A0E82020D82828E82828E03838E8C8C8F0FFFF
        FFA0A0E82020E82828E82828E05858B8E0E0F8C0C0F85858B82828E82020F018
        20E86870C0F0F0F0FFFFFFC0C0F83838E08888D8F0F8F8FFFFFFA0A0E82020E0
        2828F02828E89098E0FFFFFFA0A0E83838E02028E05858B8C8C8F0FFFFFFC8C8
        F05858B82828E0A0A0E8FFFFFFFFFFFFC0C0F83838E82028F02830E82828F038
        30E8A0A0E8E8E8F86870C02020E02020E09898E8FFFFFFE8F8F88080D82820E0
        2028E02028E03028E82828E82828E82828E82828D8A0A0E8FFFFFF8888D82020
        E02828E82828F02828F02828E82828E02828E82828F02828E02828E02828E828
        28F01820E08888D80000686028584800504000685808504000605010483800B0
        A890FFFFFFFFFFFFFFFFFFFFFFFFD0D0D0E0E0E0E0E0E0E0E0E0FFFFFFE8E8D8
        989068686028604800605000504008685800504000D0D0D0FFFFFFFFFFFF4838
        00605000605818FFFFFFFFFFFFFFFFFFB0A890504000584000605800484000B0
        A890FFFFFFF8F8F0483800686028F8F8F0FFFFFFFFFFFF888050888058FFFFFF
        FFFFFFFFFFFFF8F8F0504808504000888058FFFFFFFFFFFFFFFFFFFFFFFF4838
        00605008584800685800504000584808504808605008504000888058FFFFFFFF
        FFFFFFFFFFF0F0F0483800685800584800585008585018FFFFFFF0F8F8D0D0D0
        4838006050006048006050006050006048005848006050005850005848006858
        10FFFFFFFFFFFFFFFFFFE8E8E8E0E0E0FFFFFFFFFFFFD0D0D088805858501858
        4800584808605008888058FFFFFFFFFFFFFFFFFFE0E0E0E0E0E0E0E0E0E0E0E0
        E0E0E0C8B898483800585000584800686028E8E8E0FFFFFFF8F8F0B0A8904838
        00686028FFFFFFFFFFFFFFFFFFFFFFFFF0F0F098906850400060500058480068
        6028FFFFFFFFFFFFFFFFFFC8B898483800605000604808605008605000605000
        605000604800584800584800584800584800686028D0D0D0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81820E02830E830
        30E02828E82020E02828E83030E82828E82820E82828F03838E0A0A0E8FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0F86870
        C05858B8E8F0F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF0F0F09098E02820E82828E82828E83030F03030E83038E03838E8
        2828E82830E82830E82828E02828E83038E09098E0A0A0E83030D82828F02030
        E83838E85858B89098E0C0C0F8C0C0F8A0A0E8FFFFFFA0A0E83028E02020F080
        80D8F0F8F8FFFFFFA0A0E82828E02820E82820E83838E8C8C8F0FFFFFFA0A0E8
        1820E02830E82828E05858B8E0E0F8C0C0F83838E02028E02828E82828E83030
        E83838E83838E86870C08080D8C8C8F0FFFFFFFFFFFF9898E82020E82830E828
        30E09098E0FFFFFFA0A0E83838E02028E04868C8C0C0F8FFFFFFE0E0F85858B8
        3838E8C0C0F8FFFFFFFFFFFFA0A0E83028E02028F02830E82830E83030E0A0A0
        E8E0E0F86870C02828E81818E89898E8FFFFFFA0A0E83838E01818E82020E020
        20D81820E01820E02028E02828E83030D8A0A0E8FFFFFF8888D82020E02028E8
        3030E82828E82828E82828E83030E83028E82020E82828E83030E82830E81820
        E08888D80000585018605008685010584800605010504800604800989068FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A89058481050
        4000604800605000685010604800584808888058FFFFFFFFFFFF504810504000
        989068FFFFFFFFFFFFFFFFFF685010504800605008585000504800989068FFFF
        FFF8F8E0504010989068FFFFFFFFFFFFE8E8D8483800888058FFFFFFFFFFFFFF
        FFFFF8F8F0585008504808888058FFFFFFFFFFFFFFFFFFFFFFFF483800584800
        685010604800605008605010684808584808605000888058FFFFFFFFFFFFFFFF
        FFF8F8F0584000604808585008504800605818FFFFFFFFFFFFC8B89858400058
        5008584800605008584800605010605008605008585000604808685810FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0FFFFFFE0E0E08880585848005848
        08585008989068FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0
        D0D0484810585008504000605010C8B898FFFFFFFFFFFFC8B898483800686028
        FFFFFFFFFFFFFFFFFFFFFFFFE8E8E0686028504000604808604800686028FFFF
        FFFFFFFFFFFFFFB0A89048380058500858480060500058480860500858480860
        5008584808605010604808504000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E82830E82830
        E83028E83030E82830E82830E82828E82028E83838E0A0A0E8FFFFFFF8F8F0FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F89098E02028E05858B8
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF0F0F89098E02820E03030F02828E82830E82830E82828E82828E83030E028
        30E82028F02028F03838E09098E0FFFFFFC0C0F82020D82020F02028E82828D8
        3028F03838E85858B88080D8C0C0F8F8F8F0A0A0E82820D82020E08080D8FFFF
        FFFFFFFF9898E82020D83030F02820E83838E8C8C8F0FFFFFFA0A0E82020E028
        30E02020D85858B8E0E0F8C0C0F83838E02028E82830E83030F03028E03028E0
        2828E02020E05858B8C8C8F0FFFFFFFFFFFFA0A0E82820E83030E82828E09098
        E0FFFFFFA0A0E83838E02820F05858B8C8C8F0FFFFFFC8C8F05858B83838E0A0
        A0E8FFFFFFFFFFFF9098E02830D82828F02828E02830D83030E0C0C0F8E8E8F8
        8080D82028E81820E89898E8FFFFFFE0E0F8A0A0E89898E8A0A0E89098E09898
        E8A0A0E85858B82028E82830D8A0A0E8FFFFFF9098E02020E02030F02830E828
        30E82828E82828F02830E82830E83028E82830E82830E82830E81820E89898E8
        0000585018605000584808605000504808685010504000B0A890FFFFFFFFFFFF
        FFFFFFFFFFFFF8F8D0F8F8E8F0F0E0FFFFFFFFFFFFF0F0E8C8B8984840006048
        00605000584808685008504000686028FFFFFFFFFFFF605818585000B0A890FF
        FFFFFFFFFFF0E8E0483800605000584810685800484000B0A890FFFFFFF8F8E0
        483800F0F0E0FFFFFFFFFFFFB0A890483800888058FFFFFFFFFFFFFFFFFFF8F8
        E8585018504000989068FFFFFFFFFFFFFFFFFFFFFFFF50380068580058480868
        5800584800605000605008605010584800888058FFFFFFFFFFFFFFFFFFF8F0E8
        503800685808504808604800585018FFFFFFFFFFFFD0D0D04838006050086050
        00605008584800605008584808605008585008604808685810FFFFFFFFFFFFF0
        F0F0989068888058E0E0E0FFFFFFFFFFFFFFFFFFE0E0E0504000584808605000
        888058FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8D8B05040
        08605000584800685808888058FFFFFFFFFFFFE0E0E0483800686028FFFFFFFF
        FFFFFFFFFFFFFFFFE0E0E0484000605000605008584800686028FFFFFFFFFFFF
        FFFFFFC8B8984838006050086048006050005848086050085848006050086050
        00605008584808605000605818D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F82020E82028E82828E83030F02828F0
        2828E82828E83030F03030F02828E82828D88080D8F0F8F8FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8C8F03838E01820E88080D8FFFFFFF0
        F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0F8
        5858B82020E03030E83030E82830E82828E82828E82830E02828E82820F02028
        E04868C8C8C8F0FFFFFFFFFFFFC0C0F81820E02028F03838E89098E09098E018
        20E02820F03028E88080D8F8F8F0A0A0E82828E01820E86870C0FFFFFFFFFFFF
        9098E02020D82820F02828E05858B8C8C8F0FFFFFFA0A0E81820E02828E82028
        E86870C0E0E0F8C8C8F03838E02830E02830E02028E03838E0A0A0E8C8C8F058
        58B83028E89098E0FFFFFFFFFFFFA0A0E82020D82828E02828E09098E0FFFFFF
        A0A0E83838E02028E85858B8C8C8F0FFFFFFC8C8F05858B82020D89098E0FFFF
        FFF8F8F0A0A0E82828F02828F03028F02820F03028F0A0A0E8E8E8F86870C020
        20E81820E89898E8FFFFFFF0F0F8E0E0F8E0E0F8E0E0F8E8E8F8F0F0F8FFFFFF
        8080D82028E02830D8A0A0E8FFFFFF8888D82020D82030E02828F02028E82830
        E03028E82828E82828E82828E82830E02828E82828E82020E89898E800006860
        28604808605010504800685010584800584800989068FFFFFFFFFFFFFFFFFFFF
        FFFF585008686028605818B0A890FFFFFFFFFFFFFFFFFF888050504000605000
        605008584800685000504008F8F8F0FFFFFF888058483800F0E8E0FFFFFFFFFF
        FFC8B898483800605000685010584800504808989068FFFFFFF8F8E0585018FF
        FFFFFFFFFFFFFFFF686028504000888058FFFFFFFFFFFFFFFFFFF8F8E8584810
        584808888058FFFFFFFFFFFFFFFFFFFFFFFF5840005850085850085848006048
        00504800504000584800685000887858FFFFFFFFFFFFFFFFFFF8F8E850380058
        4808585008504000605818FFFFFFFFFFFFC8B898504000585008584800605008
        584800605010685008605008585000604808685810FFFFFFFFFFFFF0F0F06860
        28504800787038E8E8D8FFFFFFFFFFFFF0F0E8483800584800585008989068FF
        FFFFFFFFFFF0F0E8887858787038787038787038888050686028504800605008
        584800584800787038FFFFFFFFFFFFE8E8E0686028686028FFFFFFFFFFFFFFFF
        FFFFFFFFC8B898483800584808605008584000686028FFFFFFFFFFFFFFFFFFB0
        A890483800585000584808605008584808605008584808605008584808605010
        604808584800686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81820E82830E83028E83030E83030E82828E830
        30E83030E82830E02830E82828E83838E0A0A0E8FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE0E0F86870C02820E02828E08888D8E8E8E8A0A0E0E0E0
        F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8F0F88888D83030F028
        28F02830E83030E83030E83030E83030E82828E82020F02828E05858B8C0C0F8
        FFFFFFFFFFFFFFFFFFA0A0E81820E82828E83838E0C0C0F8C0C0F82020D82028
        E82020E06870C0FFFFFFA0A0E82020D81818E86870C0F0F8F8FFFFFFA0A0E028
        20D82028F02020D83838E8C8C8F0FFFFFFA0A0E81820E02030E02020D86870C0
        E0E0F8C8C8F03838E02028E02828F02828F05858B8C8C8F0FFFFFF9098E02020
        D88888D8FFFFFFFFFFFF9898E82020D82028F02828E08888D8FFFFFFA0A0E030
        30E82020F05858B8C8C8F0FFFFFFC8C8F05858B82020D88080D8E8E8F8FFFFFF
        C0C0F83838E82030E02030E82028F03030E8C0C0F8E8E8F86870C02020E02020
        E89898E8FFFFFFC8C8F06870C04868C83838E89098E0FFFFFFFFFFFF8888D818
        20E03030D8A0A0E8FFFFFF9098E02020D82820F02820F02828E82830E02828E8
        3030E83030F03030E82830E02828F02830E82020E0A0A0E80000686028604800
        504808685800584808605010504000B0A890FFFFFFFFFFFFFFFFFFFFFFFF4838
        00605800584800605018D8D8B0FFFFFFFFFFFFD0D0D048380060500058480868
        5800584000584808C8B898FFFFFFB0A890504800FFFFFFFFFFFFFFFFFF888058
        504800605000584008605800484000B0A890FFFFFFF0F0E8989068FFFFFFFFFF
        FFE8E8D8483800604800888058FFFFFFFFFFFFFFFFFFF8F8F058480858400088
        8058FFFFFFFFFFFFFFFFFFFFFFFF483800605800504808605000686028686028
        686028604808584800888050FFFFFFFFFFFFFFFFFFF8F0F04838006050085848
        08605000605818FFFFFFFFFFFFC8B89848380060500858480060500860500060
        5008584808605008585000604800685810FFFFFFFFFFFFF0F0F0686028584800
        504810B0A890FFFFFFFFFFFFE8E8E8504000584808605008888058FFFFFFFFFF
        FFE8E8E058481058480058480058480058480868500058480060500860500058
        4800686028FFFFFFFFFFFFF0F0E8888050888050FFFFFFFFFFFFFFFFFFF0F0E8
        888058504000584800605008584800686028FFFFFFFFFFFFFFFFFFC8B8984838
        0060500060480860500860500060500860500060500858480060500858480858
        5000686028E0E0E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E83030E82828E82828E02828E83030F02828
        E82828E82830E82830E82020E86870C0E8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF0F0F09098E02830E02820F03838E0C8C8F0E0E0F86870C0A0A0E8F8F8F0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8F88888D82830D82828F03030F02828
        E82828E83030E83030E82020E82020E83838E8C0C0F8E8E8F8FFFFFFFFFFFFFF
        FFFFE8F0F88080D82020E82828E83838E0C0C0F8C0C0F82020D81820E82020E0
        8080D8FFFFFF9898E82820D83030E09098E0FFFFFFFFFFFFC8C8F05858B82020
        E02020D88080D8FFFFFFFFFFFF9898E81818E82828E02020E03838E8E0E0F8C0
        C0F83838E01820E02820E82820E83838E8C8C8F0FFFFFF9898E82820D8A0A0E8
        FFFFFFFFFFFF9098E01818E83838E85858B8A0A0E0FFFFFFC8C8F06870C02020
        D88080D8FFFFFFFFFFFFC0C0F83838E02020E83838E0A0A0E8FFFFFFF8F0F080
        80D82020E82820F02828F03838E0A0A0E8E8E8F86870C02828E02020E85858B8
        E0E0F8FFFFFF8080D82020D81818E89098E0FFFFFFE0E0F86870C03838E06870
        C0C8C8F0FFFFFFC8C8F05858B82828D83838E03838E02828E82820F03030E830
        30E82828E82828E83030E82830E81820E08888D8000078703858480068501058
        4800605010504800604800989068FFFFFFFFFFFFFFFFFFFFFFFF483800604800
        604800484000B0A890FFFFFFFFFFFFF8F8E84838006050005850085848006050
        10584000888058FFFFFFE8E8D8686028FFFFFFFFFFFFFFFFFF50481058480060
        5008605008585000504800989068FFFFFFF8F8F0F0F0E8FFFFFFFFFFFF989068
        483800605000888058FFFFFFFFFFFFFFFFFFF8F8E8585008504800787038FFFF
        FFFFFFFFFFFFFFFFFFFF503800584800504808584808D0D0D0F0F0F0E8E8D848
        3800604800686028FFFFFFFFFFFFFFFFFFF8F8F0483800584800585000584800
        888050FFFFFFFFFFFFB0A8905840005850085848006050085848006050106050
        08605008585000604808685810FFFFFFFFFFFFF0F0F068602858480058501898
        9068FFFFFFFFFFFFF0F0E8604800504008585008989068FFFFFFFFFFFFE8E8E8
        6058186048006048086048086848085848086050086050085848005040006860
        28FFFFFFFFFFFFF8F0F0B0A890989068FFFFFFFFFFFFFFFFFFE8E8D868602858
        4808584808605008604800686028FFFFFFFFFFFFFFFFFFB0A890483800585008
        5848006050005848086050085848086050085848086050106050085040006860
        28D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82830E82830E82830E83028E83030E82830E82830E82828E8
        2830E82830E82028F02828E85858B8C8C8F0FFFFFFFFFFFFFFFFFFFFFFFFC8C8
        F03030D82028E03838E0A0A0E0FFFFFFC0C0F83038D89098E0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFE0E0F85858B83030E02828F02830E82830E83030E82828E8
        2830E82830E82828E06870C0C8C8F0F8F8F0FFFFFFFFFFFFF0F8F8C0C0F85858
        B83030D82028E82828E83028E86870C0A0A0E88080D83838E06870C0E0E0F8E0
        E0F85858B82820D83838E0C0C0F8FFFFFFFFFFFFE0E0F8C8C8F0C0C0F8A0A0E8
        E8E8F8FFFFFFE8E8F86870C03838E88080D88888D8A0A0E0F0F0F0E0E0F8A0A0
        E89098E09098E06870C02828E85858B8C8C8F0E0E0F8A0A0E8E0E0F8FFFFFFE0
        E0F88080D82020E05858B8C8C8F0FFFFFFFFFFFFE8E8E8D0D0D0C0C0F8C8C8F0
        FFFFFFF0F8F88888D82828E02828F02828E83838E09098E0F0F8F8A0A0E84038
        B85858B85858B89098E0E8E8F8E0E0F86870C02028E02028F03030E08080D8F0
        F0F8E0E0F88080D84038B8C0C0F8FFFFFF9098E03838E08888D8E0E0F8F8F8F0
        FFFFFFE8E8F8E0E0F8C8C8F0E0E0F88080D82020F02828F02830E82830E83028
        E82830E82830E82830E82020E88888D800007870385848005848086050005048
        00685010504000B0A890FFFFFFFFFFFFFFFFFFFFFFFF48380068501060480850
        4000C8B898FFFFFFFFFFFFFFFFFF483800685000504800605010584800685800
        504810FFFFFFF8F8E8B0A890FFFFFFFFFFFFE8E8D84840005850006050005848
        00685800484000B0A890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF58481058480060
        5000888058FFFFFFFFFFFFFFFFFFF8F8E8585018504000686028FFFFFFFFFFFF
        FFFFFFFFFFFF483800605800504800685808F8F8F0FFFFFFFFFFFF5038005040
        00605818FFFFFFFFFFFFFFFFFFF0F0F0483800605000504800605008989068FF
        FFFFFFFFFF989068504000605008604800605008584800605008584808605008
        585000604808685810FFFFFFFFFFFFF0F0E8686028584800504810B0A890FFFF
        FFFFFFFFF0F0E8605008584008605000888058FFFFFFFFFFFFE8E8E858501860
        4800584808685800584800605800504808605008584808605000605818FFFFFF
        FFFFFFFFFFFFE0E0E0B0C0A8FFFFFFFFFFFFFFFFFFD8D8B05038006050006050
        08605008584800686028FFFFFFFFFFFFFFFFFFC8B89848380060500860480060
        5000584808605008584800605008605000605008584808605000686028E8E8D8
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F82020E82028E82828E83030F02828F02828E82828E83030E82830E82828E828
        28E82830E83030E82028E85858B8C8C8F0FFFFFFFFFFFFFFFFFFC0C0F81820E0
        3030E89098E0F0F8F8FFFFFFC0C0F81820E09898E8FFFFFFFFFFFFFFFFFFFFFF
        FFC8C8F06870C02020E02828E82830F02028E82828E83030E83030E82830E820
        28E83838E8C8C8F0FFFFFFFFFFFFFFFFFFC8C8F06870C03838E02030E82028E8
        2828E02828E02828F02828E88080D8E8E8E8F0F0F8F0F8F8FFFFFFA0A0E82028
        E82830E82830E85858B8C8C8F0FFFFFFA0A0E86870C0C8C8F0FFFFFFFFFFFFE8
        E8E88080D83028E03838E0A0A0E0E8E8E8F0F0F0FFFFFFE8E8E8D0D0D0C8C8F0
        D0D0D08080D82020E82830E83838E08888D8E0E0F8FFFFFFE0E0E08080D83838
        E02828E83030E83838E08080D8E0E0F8C0C0F88080D8C8C8F0FFFFFFF0F0F090
        98E03838E02830E82830E02828E02828E03838E06870C0C8C8F0F0F0F8F0F8F8
        F0F8F8E8F0F8FFFFFFE0E0F86870C02028E82030E82028E82830E04868C8C0C0
        F8F0F0F0F0F0F0D0D0D08888D83838E82020E03838E05858B89098E0E8E8F8A0
        A0E09098E0FFFFFFFFFFFF9098E02028E82828E82828E82828E82828E82830E0
        2828E82828E82020E88888D80000686028584808605008584800685008584810
        584800989068FFFFFFFFFFFFFFFFFFFFFFFF483800584808504000989068FFFF
        FFFFFFFFFFFFFFF8F8D8483800605000605010584800685010604800504800FF
        FFFFFFFFFFE8E8E8FFFFFFFFFFFFB0A890484000604800605010685010584800
        504800989068FFFFFFF8F8F0FFFFFFFFFFFFFFFFFF4838006048006048008880
        58FFFFFFFFFFFFFFFFFFF8F8E8584810504810585010F8F8E0FFFFFFFFFFFFFF
        FFFF686028504008504810787038FFFFFFFFFFFFF8F8F0483800684808605010
        E0E0E0FFFFFFFFFFFFF8F8F0504810584808684808605818E8E8D8FFFFFFF0F0
        E868602858480860500858480060500858480060500868500860500858480858
        4808605818FFFFFFFFFFFFF0F0E8686028484810887858F0E8E0FFFFFFFFFFFF
        E8E8E8484000504000605008888058FFFFFFFFFFFFE8E8D85048105040085848
        08504810584810584808684808605008584800584800685010C8B898FFFFFFFF
        FFFFFFFFFFF8F8E8FFFFFFFFFFFFF8F8F0B0A890483800605008584808605008
        504800686028FFFFFFFFFFFFFFFFFFB0A8904838005850005848086050085848
        08605008584808605008584808605008604808584800686028D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E8
        2830E83028E83030E83030E82828E82828E83030E82830E82830E83028E82830
        E82830E82828E82828E83838E05858B88080D8A0A0E88080D82828D88080D8E8
        F8F8FFFFFFE8E8F88080D83838E8C0C0F8F0F8F8C0C0F88080D85858B83838E0
        3030E82828E83030E82830E82830E82828E82828E83030E83030E82020E88080
        D8FFFFFFFFFFFFE8E8F8A0A0E85858B82828E82828E82828E02828E02830E028
        28E02828E82828E83030E83838E05858B85858B85858B83838E02828E82828E8
        2828E83030E83838E04868C83838E82830D83838E85858B83838E83838E83030
        E82828E82830E83838E83838E86870C0E0E0F8C8C8F05858B83838E03838E838
        38E82828E82830E82828E83030E83838E83838E83838E03030E03028E82830E8
        2828E82828E83030E83838E83838E03030D83838E85858B83838E03030D82830
        E83030E82830E83030E83030E82828E82830E83838E85858B85858B83838E038
        38E0C0C0F8E8E8F86870C02020E82828E83030E82828E82830E83838E03838E8
        4868C83838E83030E02828E82828E82828E82828E83030E03838E03838E03038
        E05858B88080D83838E02828E82830E83028E83030E83030E82830E02828F028
        30E82020E09898E80000605018685808605010605000605010605010584800B0
        A890FFFFFFFFFFFFFFFFFFFFFFFF201800504000483800B0A890FFFFFFFFFFFF
        FFFFFFF8F8E8483800685800605010605000605010685000584800FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF989068585000604800685810605018605000504800B0
        A890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF483800604800685800888058FFFFFF
        FFFFFFFFFFFFF8F8E8605018504810605010F8F8E8FFFFFFFFFFFFFFFFFF6850
        10483800483800787038FFFFFFFFFFFFF8F8F0504000604808685810E0E0E0FF
        FFFFFFFFFFF0F0F0504008503800503800605008F0F0E0FFFFFFFFFFFF686028
        6048086858085848006858105848006858106050106858105848106050086050
        18FFFFFFFFFFFFF0F0E8585018483800787038F8F0E8FFFFFFFFFFFFE8E8E848
        4000504800685808888058FFFFFFFFFFFFE8E8D8484810483800483800483800
        483800503800584000685808584800604800685810D0D0D0FFFFFFFFFFFFFFFF
        FFF8F8F0FFFFFFFFFFFFFFFFFFB0A89048400068500858480868580850480068
        6028FFFFFFFFFFFFFFFFFFC8B898483800605000584808685008584808685008
        584808685008584808685810605008584800686028D0D0D0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E830
        30E83030E83030E83030E83030E83030E82830E82830E83030E82830E82830E8
        3030E83030F02828E83838E08080D8A0A0E88080D82020E08080D8FFFFFFFFFF
        FFE8E8F86870C03838E8A0A0E8F0F8F8C0C0F88080D83838E03030D83030F030
        30E83030E82830E82830E83030E82828E83030E83030F02828E88080D8FFFFFF
        FFFFFFFFFFFFA0A0E85858B82828F03030F02828E82028E82830E83030E82828
        E82828E83030E83038D83838E03838E83838E03038E83028F02828E82830E830
        30E82828D83038E03838E83030E03838E83838E83838E83030E82828E83030E8
        3030E82830F02820E85858B8E0E0F8C8C8F03838E02828E03030E83030F02830
        E82830E83030F03030E83838E83838E82830E02830E83030E82830E83030E830
        30F02828E83838E83838E83030E03838E83838E82830D82830E03030F03030E8
        3030E83030E83030E82830E82830F03838E83838E03838E03030E03838E0A0A0
        E8E8E8F86870C02828E82828E83030E83030E82830F02828E83038E83838E838
        38E82828E82830E83030E82830E82830E82828E83030E03038E02830E03838E0
        5858B83838E82828E82830E83030E83030E83030E82830E83030F02830E81820
        E89898E80000585018605008685010504800605010604800604800989068FFFF
        FFFFFFFFFFFFFFFFFFFFE8E8E0E8E8E0E8E8E0E8E8E8FFFFFFFFFFFFFFFFFF68
        6028504000605000584810584800605008604800504000FFFFFFFFFFFFFFFFFF
        FFFFFFF8F8F0504810585000685008605010605010585000504800989068FFFF
        FFFFFFFFFFFFFFFFFFFFD0D0D0504000584800585008888058FFFFFFFFFFFFFF
        FFFFF8F8E8585010685000585000686028F8F8E0FFFFFFFFFFFFE8E8E8E8E8E0
        E8E8E0E8E8E0FFFFFFFFFFFFC8B898484000605010605008605818F8F8E8FFFF
        FFFFFFFFE8E8E0E0E0E0E8E8E0F0E8E0FFFFFFFFFFFF68602858500868500860
        5010584800605010584800605010605010605010584800585000605818FFFFFF
        FFFFFFFFFFFFE8E8E8E8E8E0F0F0E8F0F8F8FFFFFFFFFFFFF0F0E85040005848
        00605010989068FFFFFFFFFFFFFFFFFFE8E8E8E8E8E0E8E8E0E8E8E0E8E8E0E0
        E0E0B0A890584800584800584800605008888050FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE8E8D8685810604800605008584808605008604800686028FFFF
        FFFFFFFFFFFFFFB0A89048380060500860480060500858480860500858480860
        5008584808605010685008504000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E82830E82830
        E83030E83030E82830E82830E83030E83030E83030E83030E82830E82830E830
        30E82830E82830E03038E83038E83038D88888D8F0F8F8FFFFFFF0F0F89098E0
        3038E0A0A0E0FFFFFFC0C0F83028F03030F03028F02828F03030E82830E82830
        E83030E83030E83030E83030F02830E82830E02028E08080D8FFFFFFE0E0F880
        80D83038E83038E82830E02830E02830E82830E02828E02828E82830E82028E0
        2830E82830E82830E83030E82828E83030E82830E82828E03030E83030E82828
        E82828E83030E82830E83030F03030F03028E82830E82830E83030E83030E828
        30E02028E02028E88080D8A0A0E83838E02830F03030E83030E83030E83030E8
        2828E82828E82828E82828E82828E82828E83030F03030E83030E82830E82830
        E83030F02828E82828E82830F02830E83030E83030E82830F02830E83030E828
        30E82830E83030E83030E83030E83030F02830E82830E83830E8C0C0F8E8E8F8
        6870C02820E83028E83030E83030E83030E82828E82828E83030E83028F03028
        F03030E83030E83030E83030E82828E82828E83030E82828E82828E82830E828
        28F03028F03028E82830E82830E83030F02830E82830E82830E82020E8A0A0E8
        0000605818604800584808605000504800685010504000B0A890FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A8905048005850
        00605000504008605000584800685000483800FFFFFFFFFFFFFFFFFFFFFFFFE8
        E8D8483800605000605008605008584808685800484000B0A890FFFFFFFFFFFF
        FFFFFFFFFFFF787038584800584808585000888058FFFFFFFFFFFFFFFFFFF8F8
        F0605010584800605000504800787038F8F8E0FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFE8E8D8686028605000584800605000504008888058FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8E04838006058005848006050085850
        00605008584800605008584800605008604808584800605818FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A890604800584808585008
        989068FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9890
        68584000584800685800504000686028FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFD8D8B0504000584800605008605000605008504008787038FFFFFFFFFFFF
        FFFFFFC8B8984838006050006050006050005848006050085848006050086050
        00605008584800605000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E83030E82828E8
        2828E82828E83030E83030E82828E82020E82828E83030E82828E82820E82828
        E82830E82820E82020E83838E0C0C0F8FFFFFFFFFFFFC0C0F83030D84868C8E8
        E8E8FFFFFFA0A0E81818E82028F02828F02830F02820E82828E83030E83030E8
        2828E82828E83030E83030E83030E82020E88080D8FFFFFFD0D0D05858B82020
        F02028E82828E82028E82828E03030E02820E82820F03030E82830E82030E028
        30E82830E82830E82028F02820E82830E83030E82828E82020E83030F03030F0
        2028E82030E02830E82830E82028E82828E83030E82828E82820F02820E82830
        E02030E03838E86870C03838E02830E82828E82020E83030E83030E82828E828
        28E82830E82830E82828E82828E82828E03030E82828E82828E83030F02830E8
        2030E82828E82828E02828E82828F02828E83030E83030F02020E82828E83030
        E83030E82828E82028E02830E82830E82028E03030E0C0C0F8E0F8F86870C028
        28E83030E82828E82828E82828E82830E82830E82828E02020E83030F03030E8
        2020E82828E83030E82830E82828E82820E82830F02030E82028E82028E83030
        E83028E82828E82828E82828E82830E02828E82828F02020E89098E000008880
        50584800605010504000685010584008584800989068E8E8D8D0D0D0D0D0D0D0
        D0D0E8E8D8D0D0D0E0E0E0D0D0D0D8D8B0686028584810605008504800605000
        605010585000685010584800584800C8B898E8E8D8D0D0D0E0E0E09890685040
        00605000584808605010685008584800504808888058F0E8E0D0D0D0E0E0E0C8
        B898484810605000584808585008888050E0E0E0D0D0D0D0D0D0D8D8B0605010
        585008604808504800585008605818B0A890FFFFFFFFFFFFFFFFFFF8F8F0F8F8
        D8605818504000585000685010605008504800605010787038B0A890FFFFFFFF
        FFFFFFFFFFF8F8F0E8E8D8686028604808584800605000605010584800605010
        584800605010685010605008584808604800605018E0E0E0D8D8B0D0D0D0D0D0
        D0D0D0D0D0D0D0D0D0D0C8B898888050605018605008504800585010888050D0
        D0D0D0D0D0D0D0D0D0D0D0D8D8B0D0D0D0D0D0D0E0E0E0D0D0D0989068584800
        584800584808604808605818B0A890D0D0D0D0D0D0D0D0D0E0E0E0D0D0D08880
        58504000584808605008584808605008504000686028E8E8D8D8D8B0D0D0D0B0
        A890584000585008584808605008584808605008584808605008584808605010
        604808584000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81820E02830E83030E83030E83030E83030E830
        30E83030E82830E82830E83030E82830E82830E83030E83030E83030E83028E8
        3028F02820F05858B8E0E0F8FFFFFFE0E0E05858B82020E88080D8FFFFFFFFFF
        FFC0C0F81820E02830E02830E82830E03030F03030E83030E82830E82830E828
        28E82828E83030E83030E82820E88080D8FFFFFFE0E0F85858B82020F02028F0
        2028F02828E83838E05858B82828F02828F02828E82828E83030E82830E82830
        E02830E02830E83030F03030E82828E82828E83030E82828E82828E83030E030
        30E03030E82830E02830E82830F02830E83030E83028F02828F02830E02030E0
        2830E83030E83030E02828E82828E83030E82828E82828E83030E03030E02830
        E82830E82830F02830E83030E82830E82830E83030E83030E83030E02830E028
        30E03030E83030E82830E02830E03030E83030E83030E83030E83030E82830E8
        2830E83030E82830E82830E02028E03030E0C0C0F8E0F8F86870C02020E82828
        E83030E82830F02830E82830E02830E03030E83030E82830E82830E83030E828
        30F02830E82830E82830E83030E82830E82830E82030E02830E02830E02830E0
        3030E83030F03030E82830E02830F02830E82020E08888D80000787038584800
        5040086858005840086050085040005850085850186050106050186058185850
        1068581060501068581060501058500060480060500060500060500058480868
        5800584000605010504800685010605018685810504810605008605000605000
        5850086050085848086058005048006050106050186858106050106858105040
        0060500058480060500058481060501858501860581860501860500050480060
        5010604800605800504800585008605818686028605018605818585018504800
        5850006858005840086050086050006050005040006050086058186860286050
        1868602858501860480058480068500058480060500858500060500860500060
        5008584808605008585000605000585008605010585018605010605018585010
        5850186858106050086858085040006050085048085850005848086858106050
        1860501060501868581058501068581058501868581058481060500060500060
        4808584800605000605818605818585018605010605018685810605010604800
        6048006050085848006050086050005850005850186850106050106050105848
        0058500858500060500860500060500860500060500858480060500858480060
        5000686028E8E8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E83030E82828E82828E02828E83030F02828
        E82828E83030F02828E82828E83030E83030E82828E82828E82830E02830E820
        28E04868C8F0F0F8F0F0F88888D82020D83838E8A0A0E0FFFFFFE8E8F88080D8
        2020E83028E82828E82828E82828E83030F02828E82828E83030F03030E82828
        E82828E83030E82828E83838E0C0C0F8FFFFFFA0A0E83838E02020D82020D830
        38D89098E0A0A0E82020E82830E82828E82820F02828E83030E82828E82828E8
        3030E82828E82828E83030E83030E82830E82830E82828E83030E83030E82820
        E82828E82830E83030E82828E82820E82828E03030E83030E83028E82828E820
        30E82828E82828E83030F02828E82828E82828E83028E83030E82030E82828E8
        3030E83030E82020E02828E83030F03030F02828E82028E03030E83030E82828
        E82828E83030E03030E02830E82828E82828E83030F02828E82828E83030F028
        28E82828E82030F02830F03038E8C0C0F8E8E8F86870C02828E82828E82020E8
        3030E83030F02828E82828E82828E82828F02828E82828E82828E83030E82828
        E82828E83030E82828E82828E82828E83030E82830E82828E82828E83030F030
        30E82020E82828E83030E82830E81820E88888D8000068602858480868501058
        4800605010504800685008605008504000605008504000605008605008504000
        5040005040006050086050105840006050105848006050106850105848006050
        1058400068501060480860500850400068480860500858480060500858480060
        5010605008584800685008504800604808504000684808504000605010605008
        5848006050105848006048086848085848085040006050086850086050105848
        0060500858480060500858480850400068480850400060480860500858480058
        4808605010605008584800605008504800605008604808504000584808504000
        6848086050086050085848006850106050085848006050105848006050106050
        1060500858480060500858480060480850400060500858400060500860480858
        4000585008584800685010605008584808605010685008584808584000584808
        5040006050085848085840006048085848006050086050085848005848086050
        1060480858480058480850480060500868480858480858480860500858480860
        5008584808605008584808605008584808584800604808584800605010605008
        5848086050085848086050085848086050085848086050106850085040006860
        28D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82830E82830E82830E83030E83030E82830E82830E83030E8
        3030E83030E83030E82830E82830E83030E82828E82828F02830E82020D84868
        C8E0E0F8C8C8F03838E01820E86870C0FFFFFFFFFFFFA0A0E83838E02828F030
        30E82830F02830E83030E82830E82830E83030E83030E83030E83030E82830E8
        2830E82830E82828E05858B8C0C0F8FFFFFFE0E0F8A0A0E8A0A0E8C8C8F0FFFF
        FFC0C0F82020E82830E82830E82828F03030E83030E83030F02830F02830E830
        30E82830F02830E83030E83030E83030E83030E82830E82830E83030E82830F0
        2830E83030E83030F03030E83030E82830E82030E82830E83030E82830E82830
        E83030E83030E83030E83030E83030E82830E82830E82830E82830E83030E830
        30E83030E83030E83030E82830E82830E83030E82830E82830E83030E83030E8
        3030E83030E82830E82830E83030E82830E82830E83030E83030E83030E82830
        E02020D82020D83038D8A0A0E0E8E8F86870C02028E02830E83030E83030E830
        30E82830F02830E83030E83030E83030E83030F03030E83030E83030E82830E8
        2830E83030E82830F02830E83030E83030E83030E83030F02830E82830E83030
        E82830E82830E82830E81820E89098E000004848106050005848086050005040
        0868580058400860500860500060500850480060500050480860500058480868
        5800504008605008605000605008504000605008584808605000584808685800
        5840086050005848006050005848086050005848006050086050006050085048
        0068580058480860500058480060500058480868580050480860500060500060
        5008584800605000584800605000584800605008584800605000605000605008
        5848006050005848006050005848006858005848006050006050006050005848
        0860500058480060500860500060500058480068580058480060500058480060
        5000584800685800584808605000605000605008584800605000584800605000
        5848006050086050006050086050006050085848006050005848006050005848
        0868580058480860500060500060500058480060500058480060500860500060
        5008584800685800584800605000584800605000584800685800584808605008
        6050006050005848006050005848006050005848006050086050006050086050
        0060500858480060500858480060500058480868580058480860500060500060
        5008584800605008584800605008605000605008584800605000605818D0D0D0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F81820E82028E82828E83030F02828F02820E82828E83030F03030F02828E820
        20E82828F03830E82828E82020E82828E83030F02828E82028E83838E0C0C0F8
        C0C0F82020E03030E89898E8FFFFFFC8C8F03838E02828E82828E82828E82828
        E83030F02020E82828E83030F03030F02828E82828E83030E83030E83030E828
        28E82828E83028F03838E86870C09098E0C0C0F8C8C8F0C0C0F89898E85858B8
        2020F02030E83030E83030E82020E82828E83030E83030E82828E82020E82830
        E83030F02828E82020E83030F03030E82828E82828E82828E83030E82828E828
        28E83030E82828E82820E82828E83030E83030E82020E82828E83030F03030F0
        2828E82020E83030F03030E82828E82828E83030E83030E82828E82828E82828
        E83030F02828E82828E83030F02828E82828E82828E82828E82828E82828E828
        28E83030E83030F02020E82828E83030F03030F02830E82028E82820F09098E0
        E0E0F8E8E8F8FFFFFFE0E0F86870C02820E83030E82828E82828E82828E83030
        E83030F02820E82020E83030F03030E82020E82828E83030E83030E82828E820
        20E83030E82830F02828E82828E83030F03030E82828E82828E82828E82830E0
        2828E82828F02028E89898E80000685810604808605010504000685010584800
        6050106050105848006050105040006050106850105048005848085848006850
        1060501058480060501050400060501060501050400068501058480060501060
        5010685010504000605010605008584800605010584800605010685008584800
        6050105048006850105048006050105848006850106050085848006050105848
        0060501060501060500858480060501060501060500858480060501058480060
        5010685008584800605010584800685010605008584800584808685010605008
        5848006050105848006050106050085848006850105048006050106050106850
        0858480060501060500858480060501058480060501068501060500858480060
        5010584800605010584800605010584800605010605008584800685010584800
        6050106050085848006050106050106050085848006050085848086050106850
        0858480860500858480868501060500850480058480868501060500858480860
        5008584808605010605010605008584808605008584808605008584808605008
        5848086050106848085848086050085848086850106050085848086050085848
        08605008584808605008584808605010605008504000686028D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81820E8
        2830E83030E83030E83030E83030E83030E83030E82830E82830E83030E82830
        E82830E83030E83030E82830E82830E83028E82828F03030E08080D8A0A0E828
        28D83838E8C8C8F0E8E8E88080D82020E02828F02830E82830E83030E83030E8
        3030E83030E83030E82830E82830E82830E82830E83030E83030E83030E83030
        E82830E82030E02830D83030E03838E03038E02830E02830E02030E02028F028
        30E82828E82828E83030E82830F02830E83030E83030F03030E83030E82830E8
        2830E83030E82830E82830E83030E83030F03030E83030E83030F02830F02830
        E83030E83030E83030E83030E83030E83030E83030E83030E82830E82830E830
        30E82830E82830E83030E83030F03030E83030E82830F02830E83030E82830E8
        2830E83030E83030E83030E83030E83030F03030E83030E82830F02830E83030
        E83030E83030E83030E83030E82830E82830E83030F02828E85858B85858B890
        98E0E8F0F8E8E8F86870C02020E82828E83030E82830F02830E83030E83030E8
        3030E83030E82830E82830E83030E82830F02830E83030E83030F03030E83030
        E83030E82830E82830E82830E82830E83030E83030F03030E82830E02830F028
        30E82020E0A0A0E8000058501860500058480868580058480860500058480860
        5008504000605008605000605008584808685800605008605000584808605008
        5040006050086050006050085848086858005848086050005848086050085848
        0868580058480860500860500060500850480060500858480860500058480868
        5800584808685800584808605000584808605008504800605008605000605008
        5848086050086050006050085848086050085848006050086050006050085848
        0868580058480860500058480860500858480068580058480860500860500060
        5008584800605008584808605000584808685800584808605008584808605000
        5848086050085848006050086050006050085848086050086050006050085848
        0060500850480060500860500060500858480868580058480860500058480860
        5008584800605008584808605008605000605008584800605008584808605008
        5848086858005848086050086050006048085848086050085848086050086050
        0060500858480860500860500860500858480860500858480860500860500060
        5008584808685808584808605000584808605008584808605008605008605008
        605008605008584800605008584808584800686028D0D0D0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81820E02830E830
        30E82828E82828E02828E83030F02828E82828E83030F02828E82828E83030E8
        3030E82828E82828E82828E82828E83030E82828E03838E04868C82828E08080
        D8FFFFFFC8C8F03030E02028E82020E83028E83030F02828E82828E82828E830
        30F02828E82828E83030F03030F02828E82828E83030E83030E82828E82028F0
        2030F02828E82820E82820E82028E82830E82828E02830E02830E02830E02820
        E82828F02828E83030E82828F02828E83030E82828E82828E83030E83030F028
        28E82828E82828E83030F03030E82828E82828F03030E83030E82828F02828E8
        2828E83030F03030E82828E82828E83030F02828E82828E83030F02828E82828
        E82828E83030F03030E82828E82828E83030E83030F02828E82828E83030F030
        30F02828E82828E83030F03030E82828E82828E83030E83030F02828E82828E8
        2828E83030F02828E82828E83030E82828E02828E82030F02830F03030E88080
        D8C0C0F86870C02820F02828F02828E83030E83030F02828E82828E82828E828
        28E82828E82828E82828E83030E82828F02828E83030E82828E82828E82828E8
        3030E83030E82828E82828E83030F03030E82828E82828F03030F02830E81818
        E89098E000006860285040005848005848085040006050085040005048006050
        0850400058480858480058480058480858480860500850400058480068500850
        4800584808584800584800584808504000605008504000584800584800584808
        5848005848005848005848006850005048005848006050005040005848005848
        0058480058480060500050400058480068500050480058480058480058480058
        4800584800584800584800584800605000584800584800584800584800584800
        5848006050005040005848006850085848005848005848005848005848006050
        0050480058480060500050480058480058480058480058480060500050400058
        4800605000584800584800584800584800584800584800584800605000584800
        6850005048005848005848005848005848005848006050005040005848006050
        0058480058480058480058480058480068500050480058480060500058480058
        4800584800584800584808605000504000584800685000504800584800584800
        5848005848005848005848006850005848006050005848005848005848005848
        0058480058480060500050400058480068500050480058480058480058480058
        4800605000584800584800504800605818D0D0D0FFFFFFF0F0F8FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E02828
        F02020E82020E82828E02828F02828E82828E82020E02828E83030E82828E820
        20E02028E82028E82828E82828E02020E82828E82828E02830D89898E8F0F0F8
        8080D82028E02828E82020E02828E82828E02828E82828F02020E82828E02828
        F02828E82828E02828E02828E82828E03030E82828E82020E02828E02828E028
        28E02828E82020E02828E82828E02028E82028E82828E02828E82828E02828E0
        2020E02828E82828E02828E02828E82020E02828E83030F02828E02020E02828
        E82828E82828E02828E82020E02828E02828E82828E82828E02020E02020E028
        28E03030F02828E82020E02828E02828E82828E82828E02020E02828F02828E8
        2828E02828E82828E82828E82828E82828E02020E82828F02828E02828E02828
        F02020E82828E02828E82020E02020E02828E82828E02828E82828F02020E028
        28E02828E82828E82828E02020E02828F03030E83030E02828E02828E82828E8
        2828E82828E02828E02020E02828E82828E02828E82828F02020E02020E02828
        F02828E82020E02828E82828E02828E02828E82020E02828E82828E82828E828
        28E82828E82828E82828E02828E82020E02828E02828E02828E81820E08080D8
        0000787038685008605010605000605010605000605010685810504000685810
        5040006858106050106050005040086050006050106858105848006858105040
        0068581060501060500060501060500060501068581060501060500060501068
        5808504000685810584800685810605008605000605010605000605010605000
        6050106050006050106858085848006858105040006858106050106858085048
        0068581060501068580858480068581058480068581060500860500060501060
        5000605010685810584800605008605010685808584800685810584800685810
        6050086050006050106050006050106858106050086050006050106858085848
        0068581058480068581060501068580858480068581058480068581058480068
        5810584800685810605008605000605010605000605010685808584800685810
        6050106858085848006858085848086858106050086050086050086050086050
        1068580858480060500860501068580858480868580858480868581060501068
        5808584808685808584808685808584808685808584808685810605008605008
        6050086050086050106850085848086858085848086858085848086858085848
        08685810605008584800686028E8E8D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F82020E82830E83030E83030E83030F0
        3030E83030E83030E83030F02830E83030E83030F03030E83030E83030E83030
        E83030F02830E82830E83030E83030F02828F02830E89098E0C8C8F03038D828
        28F02830E83830E82830E82830E83030E83030F03030E83030E83030E83030F0
        2830E82830E82830E83030E83030E83030E83030E83030E83030E82830E82830
        E83830E82830E82830E83030E83030E83030E83030E83030E83030E83030E828
        30E82830E83030E83030E83030E83030E83030E82830E83030E83030F03030E8
        3030E83030E83030E83030E83030E82830E83030E83030E83030E83030E83030
        E83030F03030E83030E83030F03030F02830E83030E83030F03030E83030E830
        30E83030F03030F02830E82830E83030E83030F02830E83030E83030F03030E8
        3030E83030E83030E83030E82830E82830E83030E83030F03030E83030E83030
        F03030F02830E83030E83030F03030E83030E83030E83030E83030E83028E828
        30E83030E83030E82830E82830E83030E83030F03030E83030E83030F03030E8
        3030E82830E83030E83030E83030E83030E83030E83030F02830E82830E83030
        F03030E83030E83030E83030E82830E82830F02830E82028E89098E000006058
        1850400058480060500058480058480058480058480058480058480060500058
        4800584800605000605008584800584800584800584800584800685000504800
        5848006050005848005848005848005848005848006050005848005848006850
        0050480058480058480058480058480058480060500058480060500058480058
        4800584800584800584800584800685000504800584800584800685000504800
        5848005848005848005848006050005848005848006050005848005848005848
        0058480058480060500058480058480060500058480058480058480058480058
        4800584800605000584800584800584800584800584800584800584800584800
        6050005848005848005848006050005848005848005848005848005848006850
        0050480058480060500058480058480058480058480058480058480058480058
        4800685000584800584800584800584800584800584800605000584800584800
        6050005848005848005848005848005848006850005848005848005848006850
        0058480058480058480058480058480060500058480058480060500058480058
        4800584800584800584800584800685000584800605000584800584800584800
        584800504800605818D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81820E02828E82828E02828E82828D82020E828
        28F02828E82828E02828F02020E82828E03030E82828E82020E02828E82828E0
        2828E82828F02020E82828E02830E82020D88080D8A0A0E82020D82828E02828
        E82828E02828E82828F02828E82828E02020E82828F02828E02828E02828F028
        28E82828E82828E83030E82828E82020E02828E82828E02828E02828E82828E0
        2828E82828F02828E82828E82828F02828E82828E02828E82020E02828E02828
        E82828E82828E02020E02828E83030E82828E82020E82828E02828E82828F028
        28E82020E02828E82828E02828E02828E82828E02020E82828F03030E82828E0
        2020E82828F02828E02828E02828F02020E82828E02828E82828F02828E82828
        E02828E02828E82828F02820E02828E02828F02828F02828E02020E02828F028
        28E82828E02828E02828E82828F02828E82828E02020E82828F02828E02828E0
        2828F02020E82828E03030E83030F02828E82020E02828E82828E02828E02828
        E82820E02828E82828F02828E82828E02020E82020E82828E02828E82020E028
        28E02828E82828E82828E02020E02828E82828E02828E82828E82828E02828E8
        2828F02828E82820E02828E82828E82028E81820E09098E00000605018685808
        6050106050006050106050006050106858105040006858105848006858106050
        1060500058480860500060501068581050400068581058480068581060501060
        5000605010605000605010685810605010605000605010685808584800685810
        5040006858106050086050006050106050006050106050006050106050006050
        1068580850400068581058480068581060501068580858480068581060501068
        5808584800685810584800685810605008605000605010605000605010685810
        5048006050086050106858085848006858105848006858106050086050006050
        1060500060501068581060500860500060501068580858480068581058480068
        5810605010685808584800685810584800685810584800685810584800685810
        6050086050006050106050006050106858085848006858106050106858085848
        0068580858480868581060500860500860500860500860501068580858480060
        5008605010685808584808685808584808685810605010685808584808685808
        5848086858085848086858085848086858106050086050086050086050086050
        1068500858480868580858480868580858480868580858480868581060500858
        5000686028D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0C0F81818E82830E83030E82830E83030E83030E83030F02830
        E83030E83030E83030F03030E82830E82830E83830E82830E82830E83030E830
        30F03030E83028E83028E82830E03838E88080D83030E83030E83030E83030E8
        3030E83030F02830E82830E83030E83030F02830E83030E83030E83030F03030
        E82830E82830E83030E83030E82830E82830E83830E83030E83030E83030E830
        30F02830E82830E83030F03030E83030E83030E83030E83030E83030E82830E8
        2830E83830E82830E82830E83030E83030E83030E83030E83030F03030E83030
        E82830E82830E83030E83030E83030E83030E83030F02030E82830E83030E830
        30F02830E83030E83030F03030E83030E83030E83030F03030E82830E82830E8
        3030E83030F03030E83030E83030F03030F02830E83030E83030F03030E83030
        E83030E83030E83030F02830E82830E83030E83030F02830E83030E83030F030
        30E83030E82830E82830E83030E83030E82830E83030E83030E83030E83030E8
        3030E83030F02830E82830E83030E83030E83030E83030E83030E83030E83030
        E82830E83030E83030E82830E82830E83030E83030E83030E83030E83030F030
        30E83030F02830E83030F03030F01820E89898E8000058481050400058480058
        4800584800605000584800584800605000584800584800584800584800584800
        5848086050005848005848006850005048005848005848005848005848005848
        0060500058480058480058480058480058480058480058480058480068500050
        4800584800605000584800584800584800584800584800605000584800584800
        6850005048005848005848005848005848005848005848005848005848006050
        0058480058480058480058480058480058480060500058480058480068500050
        4800584800584800584800584800605000584800584800605000584800584800
        5848005848005848006050005848005848006050005848005848005848005848
        0058480058480058480060500058480068500050480058480058480058480058
        4800584800605000584800584800605000584800584800584800584800584800
        6850005048005848006050005848005848005848005848005848006050005848
        0058480068500050480058480058480058480058480058480058480068500058
        4800605000584800584800584800584800584800584800605000584800584800
        6850005048005848005848005848005848006050005848005848005848006058
        18D0D0D0FFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0F81818E82828E82828E02828F02020E82828E82828E02828F02828E8
        2828E82020E02828F03030E82828E82020E02828E82828F02828E82828E02020
        E82828F02830E02030E02830E03038D82828E02828E82828E82020E02828E828
        28E02828E82828F02020E82828E02828F02828E82828E02828E02828E82828E0
        3030E82828E82020E02828E02828E82828E82828E02020E02828E82828E02828
        E82828E82828E02828E82828F02828E82020E02828E82828E02828E02828E820
        20E02828E83030F02828E02020E02828F02828E82828E02828E82020E02828E0
        2828E82828E82828E02020E02828E02828E03030F02828F02020E02828E02828
        F02828F02828E02020E02828F02828E82828E02828E82828E82828E82828E828
        28E02020E82828F02828E02828E02828F02020E82828E02828E82020E02020E0
        2828E82828E02828E82828F02020E02828E02828F02828F02828E02020E02828
        F03030E83030E82828E82020E02828E02828E82828E82828E02020E02828E828
        28E02828E82828F02828E02828E02828F02828E82020E02828E82828E02828E0
        2828E82020E02828E82828F02828E82828E82828F02828E82828E02828E82020
        E02828E02828E02828E81820E09098E000006860286858086050106050006050
        1060500060501068581050400068581050400068581060501060500050400860
        5000605010685810584800685810504000685810605010605000605010605000
        6050106858106050106050006050106858105040006858105848006858106050
        1060500060501060500060501060500060501060500060501068581058400068
        5810584000685810605010685810584800685810605010685810584800685810
        5848006858106050106050006050106050006050106858105848006050086050
        1068581058480068581058480068581060501060500060501060500060501068
        5810605010605000605010685810584800685810584800685810605010685810
        5848006858105848006858105848006858105848006858106050106050006050
        1060500060501068581058480068581060501068581058480068581058480868
        5810605008605008605010605008605010685808584800605008605010685808
        5848086858085848086858106050106858085848086858085848086858085848
        0868580858480868581060500860500860500860500860501068580858480868
        5808584808685810584808685810584808685810605008584800686028D0D0D0
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
        F82020E82830E83030E83030E83030F03030E83030E83030E83030F02830E830
        30E83030F03030E83030E83030E83030E83030F02830E82830E83030E83030F0
        2028E82030E82028F03030F03030E82830F02830E83830E82830E82830E83030
        E83030F03030E83030E83030E83030F02830E82830E82830E83830E83030E830
        30E83030E83030E83030E82830E82830E83830E82830E82830E83030E83030E8
        3030E83030E83030F03030E83030E82830F02830E83830E83030E83030E83030
        E83030E82830E83030E83030F03030E83030E83030E83030E83030E83030E828
        30E83030E83030E83030E83030E83030E83030F03030E83030E83030F03030F0
        2830E83030E83030F03030E83030E83030E83030E83030E82830E82830E83030
        E83030F02830E83030E83030F03030E83030E83030E83030E83030E82830E828
        30E83030E83030F03030E83030E83030F03030F02830E83030E83030F03030E8
        3030E83030E83030E83030E83030E82830E83030E83030E82830E82830E83030
        E83030F03030E83030E83030F03030E83030E82830E83030E83030E83030E830
        30E83030E83030F02830E82830E83030F03030E83030E83030E83030E82830E8
        2830F02830E82028E89898E80000787038504000584000585000584000584800
        5848005840005848005840005850005840005840005850005850005840005848
        0058480058480058400058500058400058400058500058400058480058480058
        4000584000585000584000584800585000584000584800584800584800584800
        5848005850005848005850005840005848005848005848005850005840005850
        0058400058480058480058500058400058480058480058480058480058500058
        4000584800585000584000584800584800584000584800585000584000584800
        5850005840005848005840005848005848005848005850005840005840005848
        0058480058480058480058480058480058500058400058480058480058500058
        4000584800584800584800584800585000584000584800585000584000584800
        5848005848005848005848005840005848005850005848005850005840005848
        0058480058480058500058400058480058500058400058480058480058480058
        4800585000584000584000584800585000584000584800584800584800584800
        5850005840005848005850005840005848005848005848005848005848005850
        00584800585000584800585000584000584800584800686028D0D0D0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E8
        2828E82828E02828E82020D82020E82828F02828E82828E02828F02020E82828
        E03030E82828E82020E02828E82828E02828E82828F02020E82828E02828F028
        28E82828E82020E02020E82828E02828E82020E02828E82828F02828E82828E0
        2020E82828F02828E02828E02828F02828E82828E82828E83030E82828E82020
        E02828E82828E02828E02828E82020E02828E82828F02828E82828E82828F028
        28E82828E02828E82020E02828E02828E82828E82828E02020E02828E83030E8
        2828E82020E82828E02828E82828F02828E82020E02828E82828E02828E02828
        E82828E02020E82828F03030E82828E02020E82828F02828E02828E02828F020
        20E82828E02828E82828F02828E82828E02828E02828E82828F02020E02828E0
        2828F02828F02828E02020E02828F02828E82828E02828E02828E82828F02828
        E82828E02020E82828F02828E02828E02828F02020E82828E03030E83030E828
        28E82020E02828E82828E02828E02828E82020E02828E82828F02828E82828E0
        2020E82020E82828E02828E82020E02828E02828E82828E82828E02020E02828
        E82828E02828E82828E82828E02828E82828F02828E82020E02828E82828E820
        28E81820E08888D8000058585858500848481048481048481048481048481060
        5818484810585010484810605818484810484810484810585018484810585010
        4848106058184848105850104848104848104848104848104848106058184848
        1048481048481060581848481058501048481060581848481048481048481048
        4810484810484810484810484810484810585010484810605818484810585010
        4848106058184848105850104848106058184848105850104848106058184848
        1048481048481048481048481058501048481058501848481058501048481060
        5818484810585010484810484810484810484810484810605818484810484810
        4848105850184848105850104848106058184848105850104848106058184848
        1058501048481060581848481058501048481048481048481048481048481058
        5018484810585010484810605818484810585010484810605818484810484810
        4848104848104848105850104848104848104848105850104848105850184848
        1058501048481058501848481058501048481058501848481058501048481060
        5818484810484810484810484810484810585010484810585018484810585010
        484810585018484810585010484810484810406038E0E0E0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82830E830
        30E82830E83030E83030E83030F02830E83030E83030E83030F03030E82830E8
        2830E83830E82830E82830E83030E83030F03030E83030E83030E83030F02830
        E83030E83030E83030E83030E83030E83030E83030F02830E82830E83030E830
        30F02830E83030E83030E83030F03030E82830E82830E83030E83030E82830F0
        2830E83830E83030E83030E83030E83030F02830E82830E83030F03030E83030
        E83030E83030E83030E83030E82830F02830E83830E82830E82830E83030E830
        30F03030E83030E83030F03030E83030E82830F03030E83030E83030E83030E8
        3030E83030F02030E82830E83030E83030F02830E83030E83030F03030E83030
        E83030E83030F03030E82830E82830E83030E83030F03030E83030E83030F030
        30F02830E83030E83030F03030E83030E83030E83030E83030F02830E82830E8
        3030E83030F02830E83030E83030F03030E83030E82830E82830E83030E83030
        E82830E83030E83030E83030F03030E83030E83030F02830E82830E83030E830
        30E83030E83030E83030E83030E83030E82830E83030E83030E82830E82830E8
        3030E83030E83030E83030E83030F03030E83030F02830E83030F03030F02020
        E88888D8000058A8C030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8
        E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030
        B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E0
        30B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8
        E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030
        B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E0
        30B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8
        E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030
        B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E0
        30B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8
        E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030
        B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E0
        30B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8
        E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030B8E030
        B8E030B8E030B8E030B8E030B8E058A8C0C8C8F0FFFFFFF0F0F8FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F81818E82828E82828E02828
        F02020E82020E82828E02828F02828E82828E82020E02828F03030E82828E820
        20E02828E82828F02828E82828E02020E82828F02828E82828E02828F02020E8
        2020E02828E82828E82020E02828E82828E02828E82828F02020E82828E02828
        F02828E82828E02828E02828E02828E03030E82828E82020E02828E02828E828
        28E82828E02020E02828E82828E02828E82828E82828E02828E82828F02828E8
        2020E02828E82828E02828E02828E82020E02828E83030F02828E02020E02828
        F02828E82828E02828E82020E02828E02828E82828E82828E02020E02020E028
        28E03030F02828F02020E02828E02828F02828F02828E02020E02828F02828E8
        2828E02828E82828E82828E82828E82828E02020E82828F02828E02828E02828
        F02020E82828E02828E82020E02020E02828E82828E02828E82828F02020E028
        28E02828F02828F02828E02020E02828F03030E83030E82828E82020E02828E0
        2828E82828E82828E02020E02828E82828E02828E82828F02020E02020E02828
        F02828E82020E02828E82828E02828E02828E82020E02828E82828F02828E828
        28E82828F02828E82828E02828E82020E02828E02828E02828E81820E08888D8
        000020C8F808C0F810C0F808C8F810B8F808C8F810C0F810C0F800B8F810C0F8
        00C0F810C0F810B8F808C8F800C0F808C8F810B8F810C0F800C0F810C0F800B8
        F810C0F810C0F808C8F810B8F808C8F810C0F808C0F810B8F808C8F810C0F808
        C0F800B8F808C8F800C0F810C0F808B8F808C8F808C0F800C0F808B8F808C8F8
        08C0F800C0F810B8F808C8F800C0F808C0F800B8F810C0F808C0F808C0F800B8
        F810C0F808C0F808C0F800B8F808C8F800C0F810C0F808B8F808C8F808C0F800
        C0F810B8F808C8F800C0F800C0F810B8F808C8F800C0F808C0F800B8F810C0F8
        08C0F800C0F808B8F808C8F810C0F808C0F808B8F808C8F810C0F808C0F800B8
        F808C8F800C0F810C0F808B8F808C8F800C0F808C0F800B8F808C8F800C0F808
        C0F800B8F810C0F808C0F800C0F808B8F808C8F810C0F808C0F800B8F810C0F8
        08C0F808C0F800B8F808C8F800C0F810C0F808B8F808C8F808C0F800C0F810B8
        F808C8F808C8F808C0F810B8F808C8F808C0F808C0F800B8F808C8F808C0F808
        C0F808B8F808C8F800C0F808C0F800B8F808C8F800C0F810C0F808B8F808C8F8
        08C0F800C0F810B8F808C8F800C0F808C0F800B8F808C8F800C0F808C0F800B8
        F810C0F808C0F808C8F820C8F8D8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0F82020E82830E83030E83030E83838E8
        3030E83030E83030E83030F02830E83030E83030F03030E83030E83030F03030
        E83030F02830E82830E83030E83030F02830E83030E83030E83838E83030E828
        30F02830E83838E82830E82830E83030E83030F03030E83030E83030E83030F0
        2830E82830E82830E83830E83030E83030E83030E83030E83030E82830F02830
        E83838E82830E82830E83030E83030E83030E83030E83030F03030E83030E828
        30F02830E83830E83030E83030E83030E83030E82830E83030E83030F03030E8
        3030E83030E83030E83030E83030E82830F03030E83030E83030E83030E83030
        E83030F03030E83030E83030F03030F02830E83030E83030F03030E83030E830
        30E83030E83030E82830E82830E83030E83030F02830E83030E83030F03030E8
        3030E83030E83030E83030E82830E82830E83030E83030F03030E83030E83030
        F03030F02830E83030E83030F03030E83030E83030E83030E83030E83030F028
        30E83030E83030E82830E82830E83030E83030F03030E83030E83030F03030E8
        3030E82830E83030E83030E83030F03030E83030E83030F02830E82830E83030
        F03030E83030E83030E83030F02830E82830F02830E82028E8A0A0E8000020C8
        F808B8F008C8F808B8F808C0F808B8F008C8F808B8F008C0F808B8F008C8F808
        B8F008C8F808B8F008C8F808B8F808C8F808B8F008C8F808B8F008C8F808B8F0
        08C8F808B8F808C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F008C0
        F808B8F008C0F808B8F008C0F808B8F008C0F808B8F808C0F808B8F008C0F808
        B8F808C0F808B8F008C8F808B8F808C0F808B8F008C0F808B8F808C0F808B8F0
        08C0F808B8F008C0F808B8F008C8F808B8F008C0F808B8F008C0F808B8F808C0
        F808B8F008C0F808B8F808C0F808B8F008C8F808B8F008C0F808B8F008C0F808
        B8F808C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F0
        08C0F808B8F008C0F808B8F008C8F808B8F008C0F808B8F008C0F808B8F008C0
        F808B8F008C0F808B8F808C0F808B8F008C0F808B8F008C0F808B8F008C0F808
        B8F808C0F808B8F008C0F808B8F808C0F808B8F808C0F808B8F808C0F808B8F0
        08C0F808B8F808C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F808C0
        F808B8F008C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F008C0F808
        B8F808C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F008C0F808B8F0
        08C0F800B8F820C8F8C0C0F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFC0C0F81820E02828E82828E02828E82020D82020E828
        28F02828E82828E02828F02020E82828E03030E82828E82020E02828E82828E0
        2828E82828F02020E82828E02828F02828E82828E82020E02020E82828E02828
        E82020E02828E82828F02828E82828E02020E82828F02828E02828E02828F028
        28E82828E82828E83030E82828E82020E02828E82828E02828E02828E82020E0
        2828E82828F02828E82828E82828F02828E82828E02828E82020E02828E02828
        E82828E82828E02020E02828E83030E82828E82020E82828E02828E82828F028
        28E82020E02828E82828E02828E02828E82020E02020E82828F03030E82828E0
        2020E82828F02828E02828E02828F02020E82828E02828E82828F02828E82828
        E02828E02828E82828F02020E02828E02828F02828F02828E02020E02828F028
        28E82020E02020E02828E82828F02828E82828E02020E82828F02828E02828E0
        2828F02020E82828E03030E83030E82828E82020E02828E82828E02828E02828
        E82020E02828E82828F02828E82828E02020E82020E82828E02828E82020E028
        28E02828E82828E82828E02020E02828E82828E02828E82828E82828E02828E8
        2828F02828E82020E02828E82828E82828F01820E09098E00000}
      Stretch = True
    end
    object imgBancoHSBC: TImage
      Left = 216
      Top = 8
      Width = 127
      Height = 29
      Picture.Data = {
        07544269746D6170F6130000424DF61300000000000036040000280000009000
        00001C0000000100080000000000C00F0000C40E0000C40E0000000100000000
        00009C9EFF001010FF00CECFFF0010101000EFEFEF00CECFCE0021202100BDBE
        BD00313031007B7DFF004241FF009C9E9C00BDBEFF006361630052515200DEDF
        DE008C8E8C0073717300ADAEAD008C8EFF006361FF00DEDFFF00ADAEFF007B7D
        7B0042414200000000000000FF00FFFFFF000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B171717171717171717171B1B1B1B0F171717171717171717171B11041B
        1B1B120D1803180E0B1B1B1B1B1B17171717171717171717171717120F1B1B1B
        1B1B1B1B1B1B1B1B1B1B040B0E081919031810041B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B160909090909090909090909090909090909090909
        09090909021B1B1B1B1B1B1B1B1B1B1B1B1B1B07070E191919190E07071B1B1B
        1B0407070E191919190D07071B180D0510061919191919191906051B1B1B0707
        0D19191919061811180819191918071B1B1B1B1B1B1B1B1B0411191919191919
        19191903171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
        1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A011301021B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B061919061B1B1B1B1B1B1B1B1B1B04031919081B1B1B1B181919
        19080B041B1B0708191903051B1B1B1B1B061919181B1B1B1B1B051819191911
        1B1B1B1B1B1B1B0703191919030D120504070B0E1908041B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
        1A01020C1A01021B1B1B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B1819190D1B1B1B1B1B1B0408191906041B1B1B
        1B181919181B1B1B1B1B1B1B0E191919101B1B1B1B1B0B1919191911041B1B1B
        1B1B1B1B051808041B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
        1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A01021B1B1B1B1B1B1B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B181918
        1B1B1B1B1B1B1B1B0F1919190B1B1B1B1B181919181B1B1B1B1B1B1B04031919
        031B1B1B1B07191919190B1B1B1B1B1B1B1B1B1B1B1B0D08041B1B1B1B1B1B1B
        1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
        021B1B0C1A1A1A01021B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B18030F1B1B1B1B1B1B1B1B1B0619190E1B1B1B
        1B181919181B1B1B1B1B1B1B1B0D191919071B1B0403191919101B1B1B1B1B1B
        1B1B1B1B1B1B1B0D0D1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
        001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A01021B1B1B1B1B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B180D1B
        1B1B1B1B1B1B1B1B1B081919181B1B1B1B181919181B1B1B1B1B1B1B1B171919
        190B1B1B17191919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B0F1B1B1B1B1B1B1B
        1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
        1B1B1B0C1A1A1A1A1A01021B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B18071B1B1B1B1B1B1B1B1B04191919181B1B1B
        1B181919181B1B1B1B1B1B1B1B171919190B1B1B06191919121B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
        1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A01021B1B1B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B111B1B
        1B1B1B1B1B1B1B1B0D1919190D1B1B1B1B181919181B1B1B1B1B1B1B1B0E1919
        19051B05191919031B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
        1B1B1B0C1A1A1A1A1A1A1A01021B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B1B1B040E19191919071B1B1B
        1B181919181B1B1B1B1B1B1B05191919061B1B10191919181B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
        1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A01021B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B1B
        1B1B1B1B1B120319191919111B1B1B1B1B181919181B1B1B1B1B1B0408191919
        071B1B11191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
        1B1B1B0C1A1A1A1A1A1A1A1A1A01021B1B1B1B1B1B1B18191906171717171717
        1717171717061919181B1B1B1B1B1B1B1B1B1B0F1819191919190D1B1B1B1B1B
        1B181919181B1B1B1B1B0B06191903121B1B1B18191919171B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
        1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A0102
        1B1B1B1B1B1B181919191919191919191919191919191919181B1B1B1B1B1B1B
        1B1B0B0319191919030B1B1B1B1B1B1B1B18191919181818081919190311041B
        1B1B1B18191919171B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B15
        1A1A1A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B1B1B14001B1B1B1B1B1B1B
        1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A011B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B1B1B1B040E191919191908051B1B1B1B1B1B1B
        1B18191906171717171819191908051B1B1B1B0D191919171B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A1B1B1B1B
        1B1B1B1B1B1B001A01021B1B1B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A1A1A00
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B05
        061919191919171B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B050619190305
        1B1B1B17191919111B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B001A1A1A1A1A1A1A1A1A1A1B1B1B1B1B1B1B1B1B001A1A1A01021B1B1B1B1B
        1B1B1B0C1A1A1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B1B05031919191908051B1B1B1B1B1B1B1B1B1B
        1B181919181B1B1B1B1B1B0F031919181B1B1B0B191919181B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1A1A1B1B1B1B
        1B1B1B1B001A1A1A1A1A01021B1B1B1B1B1B1B0C1A1A1A1A1A1A1A1A1A001B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B0619
        191919171B1B1B1B1B1B040F1B1B1B1B1B181919181B1B1B1B1B1B1B17191919
        0F1B1B0F19191919041B1B1B1B1B1B1B1B1B1B1B1B1B1B181B1B1B1B1B1B1B1B
        1B1B1B001A1A1A1A1A1A1A1A1B1B1B1B1B1B1B001A1A1A1A1A1A1A01021B1B1B
        1B1B1B0C1A1A1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B1219191903051B1B1B1B1B1B1B07171B1B1B1B
        1B181919181B1B1B1B1B1B1B0F191919071B1B1B081919190B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1A1A1B1B1B1B
        1B1B001A1A1A1A1A1A1A1A1A01021B1B1B1B1B0C1A1A1A1A1A1A1A001B1B1B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B171919
        19121B1B1B1B1B1B1B1B17171B1B1B1B1B181919181B1B1B1B1B1B1B1B191919
        071B1B1B0B191919081B1B1B1B1B1B1B1B1B1B1B1B1B0B191B1B1B1B1B1B1B1B
        1B1B1B1B1B001A1A1A1A1A1A1B1B1B1B1B001A1A1A1A1A1A1A1A1A1A1A01021B
        1B1B1B0C1A1A1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B171919031B1B1B1B1B1B1B1B1B06171B1B1B1B
        1B181919181B1B1B1B1B1B1B05191919071B1B1B1B08191919101B1B1B1B1B1B
        1B1B1B1B1B0406191B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1A1A1B1B1B1B
        001A1A1A1A1A1A1A1A1A1A1A1A1A01021B1B1B0C1A1A1A1A1A001B1B1B1B1B1B
        1B1B1B1B1B1B181919181B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B0B1919
        191B1B1B1B1B1B1B1B0719171B1B1B1B1B181919181B1B1B1B1B1B1B17191906
        1B1B1B1B1B0503191903051B1B1B1B1B1B1B1B1B040819081B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B001A1A1A1A1B1B1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01
        021B1B0C1A1A1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B181919181B1B1B1B1B1B
        1B1B1B1B1B181919181B1B1B1B04031919071B1B1B1B1B1B040619171B1B1B1B
        1B181919181B1B1B1B1B1B05191919121B1B1B1B1B1B0503191903101B1B1B1B
        1B1B1B05081919181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A1A1A1B1B001A
        1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01021B0C1A1A1A001B1B1B1B1B1B1B1B
        1B1B1B1B1B1B081919081B1B1B1B1B1B1B1B1B1B1B061919181B1B1B1B1B1719
        19030B1B1B1B1B05081919171B1B1B1B1B061919181B1B1B1B04170319190B1B
        1B1B1B1B1B1B1B0F081919190610071B0F120D19190619181B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B001A1A1B001A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A
        1A01020C1A1A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1019191919101B1B1B1B1B
        1B1B1B1B0D19191919101B1B1B1B1B1719191903180D0819061706171B1B1B04
        1119191919081818181919190E051B1B1B1B1B1B1B1B1B1B1B0B061919191919
        191919060B1B05181B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B001A001A1A1A
        1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A01131A001B1B1B1B1B1B1B1B1B1B
        1B1B1B181818181818181818181B1B1B1B05181818181818181818181B1B1B1B
        070E031919190E0B1B1B12171B1B17171717171717171717171707041B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B05101718181117051B1B1B1B051B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A
        0A0A0A0A001B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B
        1B1B}
      Stretch = True
    end
    object imgBanrisul: TImage
      Left = 352
      Top = 8
      Width = 127
      Height = 29
      Picture.Data = {
        07544269746D617042330000424D42330000000000003600000028000000A100
        00001B00000001001800000000000C3300000000000000000000000000000000
        0000F5E9D7C9A67BC9A67BC9A67BC9A67BC9A67BBE9C71BE9C71BE9C71C6B196
        FFFFFFFFFFFFFFFFFFFFFFFFC5B49FB79469B79469B79469B79469BE9C71B794
        69BE9C71B79469C3A989FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFEADDCDC9A67BC9A67BBE9C71BE9C71BE9C71BE9C71
        B79469B79469B79469B79469B79469B79469C3A989CABDADFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE9C71AF7B3A9C57009C
        5700A26210B18146C3A989FFFFFFFFFFFFB79469B79469B79469B79469C3A989
        FFFFFFFFFFFFCABDADB79469B79469B79469B79469B79469FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFBE9C71BE9C71BE9C71BE9C71BE9C71D5CDC2FFFFFFFF
        FFFFC3A989B79469B79469B79469B79469C5B49FFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFBA9FC9A67BC9A67BBE9C71BE9C71CABD
        ADFFFFFFFFFFFFFFFFFFFFFFFFC6B196B79469A56D279C57009C57009C5700A2
        6210AF7B3ABE9C71D5CDC2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        CCCCCCBE9C71AF7B3A9C57009C5700A26210B18146C5B49FFFFFFFC5B49FB794
        69B79469B79469B79469C5B49FFFFFFFFFFFFFCABDADB79469B79469B79469B7
        9469B7946900FFFDF9B181469C57009C57009C57009C57009C57009C57009C57
        009C5700C5B49FFFFFFFFFFFFFFFFFFFFFFFFFA262109C57009C57009C57009C
        57009C57009C57009C5700A26210CABDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6C5B09C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C57009C57009C57009C5700A26210B7
        9469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCABDADA262109C57009C5700
        9C57009C57009C57009C57009C5700AF7B3AC3A9899C57009C57009C57009C57
        00AF7B3AFFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C5700FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C5700CFBA9F
        FFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700B79469FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C
        5700BE9C71FFFFFFFFFFFFCABDADA56D279C57009C57009C57009C57009C5700
        9C57009C57009C57009C57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFCABDADA262109C57009C57009C57009C57009C57009C57009C5700C3A989B7
        94699C57009C57009C57009C5700B79469FFFFFFFFFFFFC5B49F9C57009C5700
        9C57009C57009C570000FFFFFFF5E9D7A262109C57009C57009C57009C57009C
        57009C57009C5700A26210FFFFFFFFFFFFFFFFFFFFFFFFC3A9899C57009C5700
        9C57009C57009C57009C57009C57009C5700AF7B3AFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDCFB39C57009C57009C57009C
        57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C5700
        9C57009C5700A26210C5B49FFFFFFFFFFFFFFFFFFFFFFFFFA262109C57009C57
        009C57009C57009C57009C57009C57009C57009C5700A262109C57009C57009C
        57009C5700AC742EFFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C5700
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C57
        00C5B49FFFFFFFFFFFFFAC742E9C57009C57009C57009C5700B79469FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C5700
        9C57009C5700BE9C71FFFFFFFFFFFFAF7B3A9C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C57009C5700B18146FFFFFFFFFFFFFF
        FFFFFFFFFFA262109C57009C57009C57009C57009C57009C57009C57009C5700
        9C5700AC742E9C57009C57009C57009C5700B79469FFFFFFFFFFFFC5B49F9C57
        009C57009C57009C57009C570000FFFFFFFFFDF9C6B1969C57009C57009C5700
        9C57009C57009C57009C57009C5700B58A54FFFFFFFFFFFFFFFFFFFFFFFFAF7B
        3A9C57009C57009C57009C57009C57009C57009C57009C5700C3A989FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6C5B09C57009C5700
        9C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C5700CABDADFFFFFFFFFFFFBE9C719C57009C
        57009C57009C57009C5700A26210B58A54B58A54A262109C57009C57009C5700
        9C57009C57009C5700AC742EFFFFFFFFFFFFC5B49F9C57009C57009C57009C57
        009C5700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C
        57009C5700C5B49FFFFFFFFFFFFFAC742E9C57009C57009C57009C5700B79469
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57
        009C57009C57009C5700BE9C71FFFFFFFFFFFFFFFFFFA262109C57009C57009C
        57009C57009C57009C57009C57009C57009C57009C57009C57009C5700C5B49F
        FFFFFFFFFFFFC3A9899C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C57009C5700B79469FFFFFFFFFFFFC5
        B49F9C57009C57009C57009C57009C570000FFFFFFFFFFFFF7F7F7B181469C57
        009C57009C57009C57009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFFF
        FFFFFFFFFFA262109C57009C57009C57009C57009C57009C57009C5700A26210
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6C5B09C57
        009C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C
        57009C57009C57009C57009C57009C57009C5700A26210D6D6D6FFFFFFAC742E
        9C57009C57009C57009C5700B18146FFFFFFFFFFFFFFFFFFFFFFFFC6B1969C57
        009C57009C57009C57009C5700AC742EFFFFFFFFFFFFC5B49F9C57009C57009C
        57009C57009C5700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C5700
        9C57009C57009C5700C5B49FFFFFFFFFFFFFAF7B3A9C57009C57009C57009C57
        00B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF
        7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFFFFFFFCABDADA26210
        9C5700B18146C5B49FFFFFFFFFFFFFC6B196A262109C57009C57009C57009C57
        00B79469FFFFFFFFFFFFB181469C57009C57009C57009C57009C57009C5700AC
        742EAF7B3AA262109C57009C57009C57009C57009C57009C5700B79469FFFFFF
        FFFFFFC5B49F9C57009C57009C57009C57009C570000FFFFFFFFFFFFF7F7F7F5
        E9D7A262109C57009C57009C57009C57009C57009C57009C5700A26210FFFFFF
        FFFFFFFFFFFFFFFFFFC3A9899C57009C57009C57009C57009C57009C57009C57
        009C5700AF7B3AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDD
        CFB39C57009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC5B49FB181469C57009C57009C57009C57009C57009C5700CABDADFFFF
        FFAF7B3A9C57009C57009C57009C5700CFBA9FFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFB794699C57009C57009C57009C5700AC742EFFFFFFFFFFFFC6B1969C5700
        9C57009C57009C57009C5700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57
        009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFAC742E9C57009C57009C
        57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFB58A54FFFFFFFFFFFFFFFFFFFFFFFFCCCCCCA56D279C57009C57009C
        57009C5700AF7B3AFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700A26210
        CABDADFFFFFFFFFFFFFFFFFFB58A549C57009C57009C57009C57009C5700B794
        69FFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C570000FFFFFFFFFFFF
        FFFFFFFFFFFFC3A989A262109C57009C57009C57009C57009C57009C57009C57
        00B58A54FFFFFFFFFFFFFFFFFFFFFFFFB181469C57009C57009C57009C57009C
        57009C57009C57009C5700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDDCFB39C57009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFB794699C57009C57009C57009C57009C5700BE
        9C71FFFFFFAF7B3A9C57009C57009C57009C5700B18146FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC5B49F9C57009C57009C57009C5700AC742EFFFFFFFFFFFFC5B4
        9F9C57009C57009C57009C57009C5700FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9C57009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFAC742E9C5700
        9C57009C57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700B79469FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6B196AF7B3A9C57009C5700
        9C57009C57009C5700B79469FFFFFFFFFFFF9C57009C57009C57009C57009C57
        00B58A54FFFFFFFFFFFFFFFFFFFFFFFFD5CDC29C57009C57009C57009C57009C
        5700BE9C71FFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C570000FFFF
        FFFFFFFFFFFFFFFFFFFFF7F7F7CB9536CB9536CB9536CB9536CB9536CB9536CB
        9536CB9536CB9536FFFFFFFFFFFFFFFFFFFFFFFFCFBA9FCB9536CB9536CB9536
        CB9536CB9536CB9536CB9536E1A52EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFDDCFB39C57009C57009C57009C57009C5700C5B49FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCABDAD9C57009C57009C57009C5700
        9C5700B79469FFFFFFC3A9899C57009C57009C57009C57009C5700AF7B3AC9A6
        7BCABDADD6C5B0FFFFFFC5B49F9C57009C57009C57009C5700AF7B3AFFFFFFFF
        FFFFC5B49F9C57009C57009C57009C57009C5700FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF9C57009C57009C57009C57009C5700C5B49FFFFFFFFFFFFFAF7B
        3A9C57009C57009C57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFC5B49FB58A54A262109C57009C57009C57009C57
        009C57009C57009C57009C5700C6B196FFFFFFFFFFFF9C57009C57009C57009C
        57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C5700
        9C57009C5700BE9C71FFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C57
        0000FFFFFFFFFFFFFFFFFFFFFFFFF2E5CDDD9300DD9300DD9300DD9300DD9300
        DD9300DD9300DD9300E1A52EFFFFFFFFFFFFFFFFFFFFFFFFDBB670DD9300DD93
        00DD9300DD9300DD9300DD9300DD9300DD9300DAB05EFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFDDCFB39C57009C57009C57009C57009C5700C5B49F
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5B49F9C57009C57009C57
        009C57009C5700C3A989FFFFFFFFFFFFAF7B3A9C57009C57009C57009C57009C
        57009C57009C57009C57009C57009C57009C57009C57009C57009C5700AC742E
        FFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C5700FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C5700C5B49FFFFFFFFF
        FFFFAC742E9C57009C57009C57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C
        71FFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C57009C57009C
        57009C57009C57009C57009C5700A56D27FFFFFFFFFFFFFFFFFF9C57009C5700
        9C57009C57009C5700C6B196FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57
        009C57009C57009C5700BE9C71FFFFFFFFFFFFC5B49F9C57009C57009C57009C
        57009C570000FFFFFFFFFFFFFFFFFFF7F7F7E1A52EDD9300DD9300DD9300DD93
        00DD9300DD9300DD9300DD9300DDCFB3FFFFFFFFFFFFFFFFFFD5CDC2DD980FDD
        9300DD9300DD9300DD9300DD9300DD9300DD9300DD980FFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDCFB39C57009C57009C57009C57009C57
        00C5B49FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C
        57009C57009C57009C5700D5CDC2FFFFFFFFFFFFD5CDC2B794699C57009C5700
        9C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C57
        00AC742EFFFFFFFFFFFFC5B49F9C57009C57009C57009C57009C5700FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C5700C5B49F
        FFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700AC742EFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C
        5700B79469FFFFFFFFFFFFDEDEDEA56D279C57009C57009C57009C57009C5700
        9C57009C57009C57009C57009C5700B79469FFFFFFFFFFFFFFFFFFFFFFFF9C57
        009C57009C57009C57009C5700CFBA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF
        7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFCFBA9F9C57009C5700
        9C57009C57009C570000FFFFFFFFFFFFF7F7F7F7C883DD9300DD9300DD9300DD
        9300DD9300DD9300DD9300DD9300DBB670E6E6E6FFFFFFFFFFFFFFFFFFE1A52E
        DD9300DD9300DD9300DD9300DD9300DD9300DD9300DD9300CFBA9FFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDCFB39C57009C57009C57009C
        57009C5700BE9C71C5B49FC5B49FC5B49FC5B49FC5B49FB79469A262109C5700
        9C57009C57009C57009C5700B58A54FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5CD
        C2BE9C71AF7B3A9C57009C57009C57009C57009C57009C57009C57009C57009C
        57009C5700AF7B3AFFFFFFFFFFFFCFBA9F9C57009C57009C57009C57009C5700
        D5CDC2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C57
        00CABDADFFFFFFFFFFFFAC742E9C57009C57009C57009C5700A56D27FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C5700
        9C57009C5700BE9C71FFFFFFFFFFFFC3A9899C57009C57009C57009C57009C57
        009C57009C5700A26210AC742EBE9C71FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9C57009C57009C57009C57009C5700CABDADFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFCABDAD9C57
        009C57009C57009C57009C570000FFFFFFFFFFFFFDEFDADD980FDD9300DD9300
        E1A52EDBB670BB812BBB812BBB812BBB812BD5CDC2E6E6E6FFFFFFFFFFFFCFBA
        9FDD9300DD9300DD9300DD9300DD9300DD9300DD9300DD9300DFAC48FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDCFB39C57009C5700
        9C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C57009C5700A56D27D5CDC2FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6C5B0D6C5B0CABDADC9A67B9C5700
        9C57009C57009C5700B58A54FFFFFFFFFFFFCABDAD9C57009C57009C57009C57
        009C5700C6B196FFFFFFFFFFFFFFFFFFFFFFFFC6B1969C57009C57009C57009C
        57009C5700CFBA9FFFFFFFFFFFFFAF7B3A9C57009C57009C57009C57009C5700
        CABDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57
        009C57009C57009C5700BE9C71FFFFFFFFFFFFBE9C719C57009C57009C57009C
        57009C5700BE9C71D6C5B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF9C57009C57009C57009C57009C5700D6C5B0FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFCA
        BDAD9C57009C57009C57009C57009C570000FFFFFFFFFFFFDFAC48DD9300DD93
        00DD980FFAF4EAF7F7F7B58A549C57009C57009C5700AF7B3AE6E6E6FFFFFFFF
        FFFFDD980FDD9300DD9300DD9300DD9300DD9300DD9300DD9300DD980FFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57
        009C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C
        57009C57009C57009C57009C5700B58A54FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD5CDC2C6B196FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6B1
        969C57009C57009C57009C5700BE9C71FFFFFFFFFFFFD6C5B09C57009C57009C
        57009C57009C5700A26210D5CDC2FFFFFFFFFFFFD6D6D6AC742E9C57009C5700
        9C57009C57009C5700FFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C57
        009C5700A26210FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF
        7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFB794699C57009C5700
        9C57009C5700AF7B3AFFFFFFFFFFFFFFFFFFFFFFFFCABDADE6E6E6FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C5700D6C5B0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700C9A67BFFFFFF
        FFFFFFD6C5B09C57009C57009C57009C57009C570000FFFFFFF7C883DD9300DD
        9300DD9300E6D5BFF7F7F7F7F7F7F6F1E8A262109C57009C57009C5700CFBA9F
        FFFFFFDFAC48DD9300DD9300DD9300DD9300DD9300DD9300DD9300DD9300CFBA
        9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDD
        CFB39C57009C57009C57009C57009C57009C57009C57009C57009C57009C5700
        9C57009C57009C57009C5700B18146D5CDC2FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFD6C5B0A262109C5700B79469FFFFFFFFFFFFFFFFFFFFFFFFD6
        C5B0A262109C57009C57009C57009C5700E6D5BFFFFFFFFFFFFFD6C5B09C5700
        9C57009C57009C57009C57009C57009C5700AF7B3AAF7B3AA262109C57009C57
        009C57009C57009C5700A26210FFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C
        57009C57009C57009C57009C5700A56D27AF7B3AAF7B3AA56D27BE9C71FFFFFF
        FFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFC9A67B9C57
        009C57009C57009C5700A26210C6B196FFFFFFD6C5B0BE9C719C5700AC742EFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C5700DDCFB3
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700C9A6
        7BFFFFFFFFFFFFD6C5B09C57009C57009C57009C57009C570000FDEDD0DD980F
        DD9300DD9300DFAC48FFFFFFFFFDF9FFFFFFF7F7F7D6C5B09C57009C57009C57
        00A26210DBB670DD9300DD9300DD9300DD9300DD9300DD9300DD9300DD9300DF
        AC48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE6D5BF9C57009C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C5700A56D27CABDADFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFD6C5B0A262109C57009C57009C57009C5700AF7B3AAF7B3A
        AC742E9C57009C57009C57009C57009C5700A56D27E6E6E6FFFFFFFFFFFFDDCF
        B39C57009C57009C57009C57009C57009C57009C57009C57009C57009C57009C
        57009C57009C57009C57009C5700B58A54FFFFFFFFFFFFFFFFFFAF7B3A9C5700
        9C57009C57009C5700A262109C57009C57009C57009C57009C57009C5700C9A6
        7BFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFFFFFFFFD5
        CDC29C57009C57009C57009C57009C57009C57009C57009C57009C57009C5700
        9C5700AC742EFFFFFFFFFFFFFFFFFFFFFFFF9C57009C57009C57009C57009C57
        00DDCFB3FFFFFFFFFFFFFFFFFFFFFFFFF7F7F7AF7B3A9C57009C57009C57009C
        5700C9A67BFFFFFFFFFFFFD6C5B09C57009C57009C57009C57009C570000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFDF9FFFFFFB58A549C
        57009C57009C57009C57009C57009C57009C57009C5700BE9C71FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFDDCFB39C57009C57009C57009C57009C5700C9A67BC5B49FC5
        B49FC6B196C3A989B58A54A262109C57009C57009C57009C5700A26210CABDAD
        FFFFFFFFFFFFFFFFFFFFFFFFC3A989A262109C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C57009C5700D6C5B0F7F7F7FFFFFFF7
        F7F7DDCFB39C57009C57009C57009C5700AC742EA56D279C57009C57009C5700
        9C57009C57009C57009C57009C57009C5700EADDCDFFFFFFFFFFFFF7F7F7AF7B
        3A9C57009C57009C57009C5700C9A67BAC742E9C57009C57009C57009C57009C
        5700C9A67BFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C71FFFFFF
        FFFFFFFFFFFFBE9C719C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C5700AF7B3AFFFFFFFFFFFFFFFFFF9C57009C57009C57009C
        57009C5700DDCFB3FFFFFFFFFFFFFFFFFFFFFFFFFFFDF9AF7B3A9C57009C5700
        9C57009C5700C9A67BFFFFFFFFFFFFDDCFB39C57009C57009C57009C57009C57
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9F7F7F7
        F6F1E8A56D279C57009C57009C57009C57009C57009C57009C5700A26210CABD
        ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C5700CFBA9F
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5CDC2AC742E9C57009C57009C57009C57
        00AC742EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5CDC2B181469C57009C57009C
        57009C57009C57009C57009C57009C57009C5700A26210D6C5B0F7F7F7F7F7F7
        F7F7F7F7F7F7E6D5BF9C57009C57009C57009C5700AF7B3AEADDCDAC742E9C57
        009C57009C57009C57009C57009C5700A26210CFBA9FF7F7F7F7F7F7F7F7F7F7
        F7F7AF7B3A9C57009C57009C57009C5700C9A67BEADDCDA262109C57009C5700
        9C57009C5700C9A67BFFFFFFFFFFFFAF7B3A9C57009C57009C57009C5700BE9C
        71FFFFFFFFFFFFFFFFFFFFFFFFC6B196A262109C57009C57009C57009C57009C
        57009C57009C57009C5700AF7B3AEADDCDFFFFFFFFFFFFFFFFFF9C57009C5700
        9C57009C57009C5700E6D5BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB181469C57
        009C57009C57009C5700C9A67BFFFFFFFFFFFFDDCFB39C57009C57009C57009C
        57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
        F9FFFDF9F7F7F7DDCFB39C57009C57009C57009C57009C57009C57009C57009C
        5700AC742EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C57
        00CABDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6B1969C57009C57009C
        57009C57009C5700CCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEADDCD
        C3A989B58A54AF7B3AA26210A26210AF7B3AB58A54C3A989F6F1E8F7F7F7F7F7
        F7F7F7F7FFFDF9F7F7F7F5E9D7C9A67BC9A67BC9A67BC9A67BCFBA9FF7F7F7F6
        F1E8C6B196AF7B3A9C5700A56D27AF7B3ABE9C71F5E9D7F7F7F7FFFDF9F7F7F7
        F7F7F7FFFDF9CFBA9FC9A67BC9A67BC9A67BC9A67BE6D5BFF7F7F7F6F1E8C9A6
        7BAC742E9C5700A26210CFBA9FFFFFFFFFFFFFCFBA9FC9A67BC9A67BC9A67BBE
        9C71D6C5B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3A989AF7B3AAC742E
        9C5700A56D27AF7B3ABE9C71D6C5B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9A6
        7BC9A67BC9A67BC9A67BC9A67BF5E9D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF
        BA9FC9A67BC9A67BC9A67BC9A67BE6D5BFFFFFFFFFFFFFDDCFB39C57009C5700
        9C57009C57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF7F7F7F7F7F7F7F7F7B58A54BB812BBB812BBB812BBB812BBB812B
        BB812BBB812BAC742ECFBA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C
        57009C5700CABDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6B1969C5700
        9C57009C57009C57009C5700CFBA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFFFF
        FFFDF9FFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57
        009C57009C57009C57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFDF9F7F7F7F6F1E8DD980FDD9300DD9300DD9300DD93
        00DD9300DD9300DD9300EEA104FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C5700
        9C57009C57009C5700D6C5B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB181
        469C57009C57009C57009C57009C5700CABDADFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFF
        FFEADDCDE6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6
        D5BF9C57009C57009C57009C57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFDF9DFAC48DD9300DD9300DD9300DD
        9300DD9300DD9300DD9300DD9300CFBA9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57
        009C57009C57009C57009C5700C3A989D6C5B0D6C5B0CABDADC6B196BE9C71A5
        6D279C57009C57009C57009C57009C57009C5700D5CDC2FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEA
        DDCDA56D279C57009C5700BE9C71FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDDCFB39C57009C57009C57009C57009C570000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9E6D5BFDD9300DD9300DD9300
        DD9300DD9300DD9300DD9300DD9300DFAC48FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6
        D5BF9C57009C57009C57009C57009C57009C57009C57009C57009C57009C5700
        9C57009C57009C57009C57009C57009C57009C5700A56D27FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFDF9A56D279C57009C57009C57009C5700C9A67BFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C570000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF8ECDD980FDD9300DD93
        00DD9300DD9300DD9300DD9300DD9300DD980FF5E9D7FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE6D5BF9C57009C57009C57009C57009C57009C57009C57009C57009C57
        009C57009C57009C57009C57009C57009C57009C57009C5700CFBA9FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFE6D5BF9C57009C57009C57009C57009C5700AC742EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C570000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFAC48DD9300DD
        9300DD9300DD9300DD9300DD9300DD9300DD9300DDCFB3FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C57009C57009C57009C
        57009C57009C57009C57009C57009C57009C57009C5700A26210CFBA9FEFEFEF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFEADDCD9C57009C57009C57009C57009C5700AF7B3AFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C57
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BFDD9300
        DD9300DD9300DD9300DD9300DD9300DD9300DD9300DFAC48FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C57009C57009C5700
        9C57009C57009C57009C57009C57009C57009C5700AC742EC9A67BEADDCDFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB181469C57009C57009C57009C5700C6B1
        96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C57009C57009C
        57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEFDAE1A5
        2EDD9300DD9300DD9300DD9300DD9300DD9300DD9300E1A52EF5E9D7FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4EAE6D5BFE6D5BFE6D5BFE6D5BFE6D5
        BFE6D5BFE6D5BFE6D5BFDDCFB3E6D5BFDDCFB3E6D5BFF7F7F7F7F7F7F7F7F7F7
        F7F7FFFDF9FFFFFFFFFDF9FFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F1E8BE9C71A26210A56D27C6
        B196FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57009C5700
        9C57009C57009C570000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9FFFFFFFFFDF9FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFDF9FFFFFFFFFDF9FFFFFFFFFDF9FFFFFF
        FFFDF9FFFFFFFFFDF9FFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFDF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D5BF9C57
        009C57009C57009C57009C570000}
      Stretch = True
    end
  end
  object RLPDFFilter: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 568
    Top = 8
  end
  object rpsSetup: TRLPreviewSetup
    Left = 392
    Top = 8
  end
end
