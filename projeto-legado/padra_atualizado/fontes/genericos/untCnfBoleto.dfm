inherited frmCnfBoleto: TfrmCnfBoleto
  Left = 0
  Top = 0
  Width = 800
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o de Boleto'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 512
    Width = 794
    ExplicitTop = 512
    ExplicitWidth = 794
    DesignSize = (
      794
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pgcDados: TPageControl
    Top = 173
    Width = 794
    Height = 339
    Visible = False
    ExplicitTop = 173
    ExplicitWidth = 794
    ExplicitHeight = 339
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 307
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 23
    Align = alTop
    ParentBackground = False
    TabOrder = 3
    object lblTitulo: TLabel
      Left = 1
      Top = 1
      Width = 792
      Height = 21
      Align = alClient
      Alignment = taCenter
      Caption = 'CONFIGURA'#199#195'O DE BOLETO'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 148
      ExplicitHeight = 14
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 23
    Width = 794
    Height = 121
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 25
      Top = 8
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object Label2: TLabel
      Left = 47
      Top = 31
      Width = 12
      Height = 14
      Alignment = taRightJustify
      Caption = 'ID:'
    end
    object Label3: TLabel
      Left = 134
      Top = 31
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
    end
    object Label4: TLabel
      Left = 239
      Top = 31
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Coluna:'
    end
    object Label5: TLabel
      Left = 357
      Top = 31
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object Label6: TLabel
      Left = 8
      Top = 54
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chr Antes:'
    end
    object Label7: TLabel
      Left = 342
      Top = 54
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chr Depois:'
    end
    object Label8: TLabel
      Left = 7
      Top = 87
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodBco: TDBEditFocus
      Tag = 99
      Left = 61
      Top = 4
      Width = 56
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_CODBCO'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnKeyPress = dbeCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeIdenti: TDBEditFocus
      Tag = 99
      Left = 61
      Top = 27
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_IDENTI'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinImp: TDBEditFocus
      Tag = 99
      Left = 166
      Top = 27
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_LINIMP'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeColImp: TDBEditFocus
      Tag = 99
      Left = 277
      Top = 27
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_COLIMP'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 401
      Top = 27
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_MARGEM'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeChrAnt: TDBEditFocus
      Tag = 99
      Left = 61
      Top = 50
      Width = 273
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_CHRANT'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeChrDep: TDBEditFocus
      Tag = 99
      Left = 401
      Top = 50
      Width = 383
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNF_CHRDEP'
      DataSource = dtsCnfGen
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object memDesCam: TMemoFocus
      Tag = 99
      Left = 61
      Top = 73
      Width = 724
      Height = 43
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      ScrollBars = ssVertical
      TabOrder = 7
      OnKeyPress = memDesCamKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtNomBan: TEditFocus
      Left = 118
      Top = 4
      Width = 216
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBotoesCnf: TPanel [5]
    Left = 0
    Top = 144
    Width = 794
    Height = 29
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    DesignSize = (
      794
      29)
    object btnIrGrid: TBitBtnLocked
      Left = 638
      Top = 3
      Width = 147
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Volta '#224' Lista'
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
      TabOrder = 2
      OnClick = btnIrGridClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 156
      Top = 3
      Width = 147
      Height = 22
      Caption = '&Confirma Informa'#231#245'es'
      Enabled = False
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnNovaConf: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 147
      Height = 22
      Caption = '&Nova Configura'#231#227'o'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnNovaConfClick
    end
  end
  object dbgConfigs: TDBGrid [6]
    Left = 0
    Top = 173
    Width = 794
    Height = 339
    Align = alClient
    DataSource = dtsCnfGen
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = popConfig
    TabOrder = 6
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgConfigsKeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_CODBCO'
        Title.Alignment = taCenter
        Title.Caption = 'Bco'
        Width = 55
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_IDENTI'
        Title.Alignment = taCenter
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_MARGEM'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_LINIMP'
        Title.Alignment = taCenter
        Title.Caption = 'Lin'
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_COLIMP'
        Title.Alignment = taCenter
        Title.Caption = 'Col'
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_CHRANT'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CNF_CHRDEP'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 794
    ExplicitTop = 512
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 633
      Width = 161
      ExplicitLeft = 633
      ExplicitWidth = 161
    end
    inherited pnlInfo: TPanel
      Width = 633
      ExplicitWidth = 633
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 8
  end
  object popConfig: TPopupMenu
    OnPopup = popConfigPopup
    Left = 648
    Top = 8
    object mnuIncluir: TMenuItem
      Caption = 'Incluir Registro'
      OnClick = mnuIncluirClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuEditaReg: TMenuItem
      Caption = 'Edita Registro'
      OnClick = mnuEditaRegClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuDeletaReg: TMenuItem
      Caption = 'Deleta Registro'
      OnClick = mnuDeletaRegClick
    end
  end
  object dtsCnfGen: TDataSource
    Left = 360
    Top = 208
  end
end
