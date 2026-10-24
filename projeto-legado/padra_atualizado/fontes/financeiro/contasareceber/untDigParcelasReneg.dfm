inherited frmDigParcelasReneg: TfrmDigParcelasReneg
  Left = 338
  Top = 201
  Width = 326
  Height = 419
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Condi'#231#227'o de Pagamento'
  Position = poMainFormCenter
  ExplicitWidth = 326
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 342
    Width = 320
    ExplicitTop = 342
    ExplicitWidth = 320
    DesignSize = (
      320
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 316
      ExplicitWidth = 316
    end
    inherited btnSair: TBitBtnLocked
      Left = 184
      ExplicitLeft = 184
    end
  end
  inherited pnlStatus: TPanel
    Top = 374
    Width = 320
    ExplicitTop = 374
    ExplicitWidth = 320
    inherited pnlNomeForm: TPanel
      Left = -69
      Width = 389
      ExplicitLeft = -69
      ExplicitWidth = 389
    end
    inherited pnlInfo: TPanel
      Width = 145
      ExplicitWidth = 145
    end
  end
  inherited pgcDados: TPageControl
    Top = 30
    Width = 320
    Height = 312
    ExplicitTop = 30
    ExplicitWidth = 320
    ExplicitHeight = 312
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 312
      ExplicitHeight = 280
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 320
    Height = 30
    Align = alTop
    Color = 16770261
    TabOrder = 3
    object Label3: TLabel
      Left = 13
      Top = 11
      Width = 123
      Height = 13
      AutoSize = False
      Caption = 'Quantidade de Parcelas:'
    end
    object lblQtdPar: TLabel
      Left = 140
      Top = 11
      Width = 12
      Height = 14
      Caption = '00'
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 30
    Width = 320
    Height = 312
    Align = alClient
    Color = 16770261
    TabOrder = 4
    object Label2: TLabel
      Left = 49
      Top = 6
      Width = 57
      Height = 12
      AutoSize = False
      Caption = 'Vencimento'
    end
    object lblParc01: TLabel
      Left = 34
      Top = 23
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '01'
    end
    object lblParc02: TLabel
      Left = 34
      Top = 47
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '02'
    end
    object lblParc03: TLabel
      Left = 34
      Top = 69
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '03'
    end
    object lblParc04: TLabel
      Left = 34
      Top = 92
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '04'
    end
    object lblParc05: TLabel
      Left = 34
      Top = 116
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '05'
    end
    object lblParc06: TLabel
      Left = 34
      Top = 138
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '06'
    end
    object lblParc07: TLabel
      Left = 34
      Top = 161
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '07'
    end
    object lblParc08: TLabel
      Left = 34
      Top = 185
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '08'
    end
    object lblParc09: TLabel
      Left = 34
      Top = 208
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '09'
    end
    object lblParc10: TLabel
      Left = 34
      Top = 230
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '10'
    end
    object lblParc11: TLabel
      Left = 35
      Top = 253
      Width = 11
      Height = 22
      Alignment = taCenter
      Caption = '11'
    end
    object lblParc12: TLabel
      Left = 34
      Top = 276
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '12'
    end
    object Label1: TLabel
      Left = 182
      Top = 6
      Width = 57
      Height = 12
      AutoSize = False
      Caption = 'Vencimento'
    end
    object lblParc13: TLabel
      Left = 167
      Top = 23
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '13'
    end
    object lblParc14: TLabel
      Left = 167
      Top = 47
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '14'
    end
    object lblParc15: TLabel
      Left = 167
      Top = 69
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '15'
    end
    object lblParc16: TLabel
      Left = 167
      Top = 92
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '16'
    end
    object lblParc17: TLabel
      Left = 167
      Top = 116
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '17'
    end
    object lblParc18: TLabel
      Left = 167
      Top = 138
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '18'
    end
    object lblParc19: TLabel
      Left = 167
      Top = 161
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '19'
    end
    object lblParc20: TLabel
      Left = 167
      Top = 185
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '20'
    end
    object lblParc21: TLabel
      Left = 167
      Top = 208
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '21'
    end
    object lblParc22: TLabel
      Left = 167
      Top = 230
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '22'
    end
    object lblParc23: TLabel
      Left = 167
      Top = 253
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '23'
    end
    object lblParc24: TLabel
      Left = 167
      Top = 276
      Width = 12
      Height = 22
      Alignment = taCenter
      Caption = '24'
    end
    object mskParc01: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 20
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc02: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 43
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc03: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 66
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc04: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 89
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc05: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 112
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc06: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 135
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc07: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 158
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc08: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 181
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc09: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 204
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc10: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 227
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 9
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc11: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 250
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 10
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc12: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 273
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc13: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 20
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 12
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc14: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 43
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 13
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc15: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 66
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 14
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc16: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 89
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 15
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc17: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 112
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 16
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc18: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 135
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 17
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc19: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 158
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 18
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc20: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 181
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 19
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc21: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 204
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 20
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc22: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 227
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 21
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc23: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 250
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 22
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskParc24: TMaskEditFocus
      Tag = 99
      Left = 183
      Top = 273
      Width = 61
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 23
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pnlBotoesBaixa: TPanel [5]
    Left = 0
    Top = 342
    Width = 320
    Height = 32
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 5
    DesignSize = (
      320
      32)
    object btnSairDig: TBitBtnLocked
      Left = 215
      Top = 5
      Width = 98
      Height = 22
      Anchors = [akRight, akBottom]
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
      Left = 5
      Top = 5
      Width = 98
      Height = 22
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
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 104
  end
end
