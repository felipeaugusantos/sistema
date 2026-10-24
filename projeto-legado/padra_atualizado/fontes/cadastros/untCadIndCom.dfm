inherited frmCadIndCom: TfrmCadIndCom
  Left = 251
  Top = 153
  Width = 716
  Height = 571
  BorderIcons = [biSystemMenu]
  Caption = 'Indices de comiss'#227'o para metas de vendas'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 716
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 710
    Height = 26
    TabOrder = 3
    ExplicitTop = 500
    ExplicitWidth = 710
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 78
      Width = 553
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 706
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 631
      Top = 2
      Align = alRight
      ExplicitLeft = 627
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 76
      Height = 22
      Align = alLeft
      Caption = '&Gravar'
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
      OnClick = btnGravarClick
      ExplicitLeft = 6
      ExplicitTop = 3
    end
  end
  object pnlMetaAtingida: TPanel [2]
    Left = 0
    Top = 0
    Width = 710
    Height = 230
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 284
      Top = 47
      Width = 54
      Height = 14
      Caption = 'Valor Inicial'
    end
    object Label2: TLabel
      Left = 407
      Top = 47
      Width = 50
      Height = 14
      Caption = 'Valor Final'
    end
    object Label3: TLabel
      Left = 527
      Top = 47
      Width = 60
      Height = 14
      Caption = '% Comiss'#227'o'
    end
    object Label4: TLabel
      Left = 8
      Top = 47
      Width = 83
      Height = 14
      Caption = 'Descri'#231#227'o (N'#237'vel)'
    end
    object Label5: TLabel
      Left = 8
      Top = 7
      Width = 693
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = #205'ndice de Meta Atingida'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 207
      Width = 190
      Height = 14
      Caption = 'Pressione [DEL] para remover registros'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 35
      Width = 691
      Height = 2
    end
    object dbgComAt: TDBGridCitel
      Left = 8
      Top = 87
      Width = 693
      Height = 120
      Ctl3D = True
      DataSource = dtsComIAT
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 5
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDblClick = dbgComAtDblClick
      OnKeyDown = dbgComAtKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'COM_DESCRI'
          Title.Caption = 'Descri'#231#227'o'
          Width = 260
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COM_VALINI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Inicial'
          Width = 121
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COM_VALFIN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Final'
          Width = 121
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'COM_PERCOM'
          Title.Alignment = taRightJustify
          Title.Caption = '% Comiss'#227'o'
          Width = 68
          Visible = True
        end>
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 8
      Top = 63
      Width = 273
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = edtDescriEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValIni: TEditFocus
      Tag = 99
      Left = 282
      Top = 63
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      Text = '0,00'
      OnEnter = edtValIniEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFin: TEditFocus
      Tag = 99
      Left = 404
      Top = 63
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 2
      Text = '0,00'
      OnEnter = edtValFinEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPerCom: TEditFocus
      Tag = 99
      Left = 526
      Top = 63
      Width = 65
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0,00'
      OnEnter = edtPerComEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnAdicionarAt: TBitBtnLocked
      Left = 592
      Top = 63
      Width = 108
      Height = 22
      Caption = '&Confirma'
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
      TabOrder = 4
      OnClick = btnAdicionarAtClick
    end
  end
  object pnlFaturamento: TPanel [3]
    Left = 0
    Top = 230
    Width = 710
    Height = 40
    Align = alClient
    Color = 16770261
    TabOrder = 1
    ExplicitHeight = 38
    object Label13: TLabel
      Left = 416
      Top = 9
      Width = 154
      Height = 18
      Caption = 'Meta de Faturamento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtMeta: TEditFocus
      Tag = 99
      Left = 578
      Top = 8
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
      OnEnter = edtMetaEnter
      OnExit = edtMetaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlMetasNAtingidas: TPanel [4]
    Left = 0
    Top = 270
    Width = 710
    Height = 230
    Align = alBottom
    Color = 16770261
    TabOrder = 2
    ExplicitTop = 268
    object Label7: TLabel
      Left = 284
      Top = 49
      Width = 54
      Height = 14
      Caption = 'Valor Inicial'
    end
    object Label8: TLabel
      Left = 407
      Top = 49
      Width = 50
      Height = 14
      Caption = 'Valor Final'
    end
    object Label9: TLabel
      Left = 527
      Top = 49
      Width = 60
      Height = 14
      Caption = '% Comiss'#227'o'
    end
    object Label10: TLabel
      Left = 8
      Top = 49
      Width = 83
      Height = 14
      Caption = 'Descri'#231#227'o (N'#237'vel)'
    end
    object Label11: TLabel
      Left = 8
      Top = 7
      Width = 691
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Caption = #205'ndice de Meta N'#227'o Atingida'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 209
      Width = 190
      Height = 14
      Caption = 'Pressione [DEL] para remover registros'
    end
    object Bevel2: TBevel
      Left = 8
      Top = 38
      Width = 691
      Height = 2
    end
    object dbeComNt: TDBGridCitel
      Left = 8
      Top = 89
      Width = 693
      Height = 120
      DataSource = dtsComINT
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 5
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDblClick = dbeComNtDblClick
      OnKeyDown = dbeComNtKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'COM_DESCRI'
          Title.Caption = 'Descri'#231#227'o'
          Width = 259
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_VALINI'
          Title.Caption = 'Valor Inicial'
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_VALFIN'
          Title.Caption = 'Valor Final'
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_PERCOM'
          Title.Caption = '% Comiss'#227'o'
          Width = 68
          Visible = True
        end>
    end
    object edtDescriNA: TEditFocus
      Tag = 99
      Left = 8
      Top = 65
      Width = 273
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = edtDescriNAEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValIniNA: TEditFocus
      Tag = 99
      Left = 282
      Top = 65
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      Text = '0,00'
      OnEnter = edtValIniNAEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFinNA: TEditFocus
      Tag = 99
      Left = 404
      Top = 65
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 2
      Text = '0,00'
      OnEnter = edtValFinNAEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPerComNA: TEditFocus
      Tag = 99
      Left = 526
      Top = 65
      Width = 65
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      Text = '0,00'
      OnEnter = edtPerComNAEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnAdicionarNt: TBitBtnLocked
      Left = 592
      Top = 65
      Width = 108
      Height = 22
      Caption = 'C&onfirma'
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
      TabOrder = 4
      OnClick = btnAdicionarNtClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 526
    Width = 710
    TabOrder = 4
    ExplicitTop = 526
    ExplicitWidth = 710
    inherited pnlNomeForm: TPanel
      Left = 539
      ExplicitLeft = 539
    end
    inherited pnlInfo: TPanel
      Width = 539
      ExplicitWidth = 539
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1096
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1064
    Top = 8
  end
  object dtsComIAT: TDataSource
    Left = 672
    Top = 8
  end
  object dtsComINT: TDataSource
    Left = 640
    Top = 8
  end
end
