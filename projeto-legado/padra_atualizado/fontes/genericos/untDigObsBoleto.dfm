inherited frmDigObsBoleto: TfrmDigObsBoleto
  Left = 282
  Top = 92
  Width = 411
  Height = 234
  BorderIcons = [biSystemMenu]
  Caption = 'Selecione as observa'#231#245'es que sair'#227'o no boleto'
  Position = poMainFormCenter
  ExplicitWidth = 411
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 189
    Width = 405
    ExplicitTop = 189
    ExplicitWidth = 405
    DesignSize = (
      405
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 401
      ExplicitWidth = 401
    end
    inherited btnSair: TBitBtnLocked
      Left = 319
      ExplicitLeft = 319
    end
  end
  inherited pgcDados: TPageControl
    Top = 396
    Width = 405
    Height = 0
    TabOrder = 3
    Visible = False
    ExplicitTop = 396
    ExplicitWidth = 405
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 397
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 405
    Height = 396
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object pnlBotoesBaixa: TPanel
      Left = 2
      Top = 158
      Width = 401
      Height = 27
      Align = alTop
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 1
      object btnSairDig: TBitBtnLocked
        Left = 301
        Top = 2
        Width = 98
        Height = 23
        Align = alRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
      object btnSalvar: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 98
        Height = 23
        Align = alLeft
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnSalvarClick
      end
    end
    object pnlDuplics: TPanel
      Left = 2
      Top = 2
      Width = 401
      Height = 156
      Align = alTop
      ParentColor = True
      TabOrder = 0
      object pnlHeader: TPanel
        Left = 1
        Top = 1
        Width = 399
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
      end
      object pnl1: TPanel
        Left = 1
        Top = 22
        Width = 399
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label4: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtObservacao1: TEditFocus
          Tag = 99
          Left = 48
          Top = 2
          Width = 335
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkSel1: TCheckBox
          Left = 27
          Top = 6
          Width = 16
          Height = 17
          TabOrder = 0
        end
      end
      object pnl2: TPanel
        Left = 1
        Top = 47
        Width = 399
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object Label5: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtObservacao2: TEditFocus
          Tag = 99
          Left = 48
          Top = 2
          Width = 335
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkSel2: TCheckBox
          Left = 27
          Top = 4
          Width = 16
          Height = 17
          TabOrder = 0
        end
      end
      object pnl3: TPanel
        Left = 1
        Top = 72
        Width = 399
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object Label6: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtObservacao3: TEditFocus
          Tag = 99
          Left = 48
          Top = 2
          Width = 335
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkSel3: TCheckBox
          Left = 27
          Top = 4
          Width = 16
          Height = 17
          TabOrder = 0
        end
      end
      object pnl5: TPanel
        Left = 1
        Top = 122
        Width = 399
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 5
        object Label8: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtObservacao5: TEditFocus
          Tag = 99
          Left = 48
          Top = 2
          Width = 335
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkSel5: TCheckBox
          Left = 27
          Top = 4
          Width = 16
          Height = 17
          TabOrder = 0
        end
      end
      object pnl4: TPanel
        Left = 1
        Top = 97
        Width = 399
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        object Label7: TLabel
          Left = 15
          Top = 5
          Width = 6
          Height = 14
          Caption = '4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtObservacao4: TEditFocus
          Tag = 99
          Left = 48
          Top = 2
          Width = 335
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkSel4: TCheckBox
          Left = 27
          Top = 4
          Width = 16
          Height = 17
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 189
    Width = 405
    ExplicitTop = 189
    ExplicitWidth = 405
    inherited pnlNomeForm: TPanel
      Left = 234
      ExplicitLeft = 234
    end
    inherited pnlInfo: TPanel
      Width = 234
      ExplicitWidth = 234
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 352
  end
end
