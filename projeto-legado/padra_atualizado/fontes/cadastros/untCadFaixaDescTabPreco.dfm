inherited frmCadFaixaDescTabPreco: TfrmCadFaixaDescTabPreco
  Width = 476
  Height = 423
  BorderIcons = [biSystemMenu]
  Caption = 'Faixas de Desconto por Tabela de Pre'#231'o'
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 476
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 350
    Width = 470
    TabOrder = 3
    ExplicitTop = 350
    ExplicitWidth = 470
    inherited FlwBotoes: TFlowPanel
      Width = 466
      TabOrder = 1
      ExplicitTop = 2
      ExplicitWidth = 466
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 385
      TabOrder = 2
      ExplicitLeft = 385
    end
    object btnGravar: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 90
      Height = 22
      Caption = '&Gravar'
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
  end
  object pnlGrid: TPanel [2]
    Left = 0
    Top = 169
    Width = 470
    Height = 181
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label12: TLabel
      Left = 7
      Top = 192
      Width = 228
      Height = 14
      Caption = 'Pressione [DEL] para remover registros do Grid'
    end
    object dbgCadTab: TDBGridCitel
      Left = 1
      Top = 1
      Width = 468
      Height = 188
      Align = alTop
      DataSource = dtsCadTab
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DESINI'
          Title.Alignment = taRightJustify
          Title.Caption = '% Desc. Ini.'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESFIN'
          Title.Alignment = taRightJustify
          Title.Caption = '% Desc. Fin.'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMVIS'
          Title.Alignment = taRightJustify
          Title.Caption = '% Com. a Vista'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPRA'
          Title.Alignment = taRightJustify
          Title.Caption = '%Com. a Prazo'
          Width = 110
          Visible = True
        end>
    end
  end
  object pnlDesconto: TPanel [3]
    Left = 0
    Top = 0
    Width = 470
    Height = 75
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 14
      Width = 80
      Height = 14
      Caption = 'Tabela de Pre'#231'o:'
    end
    object cmbTabPre: TComboBoxFocus
      Left = 89
      Top = 9
      Width = 156
      Height = 22
      Style = csOwnerDrawFixed
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnChange = cmbTabPreChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object rdgTipOpe: TRadioGroup
      Left = 250
      Top = 4
      Width = 208
      Height = 62
      Caption = 'Tipo Operador'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Vendedor'
        'Vendedor 2'
        'Digitador'
        'Representante')
      TabOrder = 1
      OnClick = cmbTabPreChange
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 75
    Width = 470
    Height = 94
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object Label2: TLabel
      Left = 6
      Top = 8
      Width = 75
      Height = 14
      Caption = 'Desconto Inicial'
    end
    object Label3: TLabel
      Left = 172
      Top = 8
      Width = 71
      Height = 14
      Caption = 'Desconto Final'
    end
    object Label4: TLabel
      Left = 172
      Top = 48
      Width = 100
      Height = 14
      Caption = '% Comiss'#227'o a Prazo'
    end
    object Label8: TLabel
      Left = 7
      Top = 48
      Width = 97
      Height = 14
      Caption = '% Comiss'#227'o a Vista'
    end
    object edtDesIni: TEditFocus
      Tag = 99
      Left = 7
      Top = 22
      Width = 152
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesFin: TEditFocus
      Tag = 99
      Left = 170
      Top = 22
      Width = 152
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtComPra: TEditFocus
      Tag = 99
      Left = 172
      Top = 62
      Width = 150
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 3
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnConfirma: TBitBtnLocked
      Left = 328
      Top = 62
      Width = 77
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
      OnClick = btnConfirmaClick
    end
    object edtComVis: TEditFocus
      Tag = 99
      Left = 7
      Top = 62
      Width = 151
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
      Text = '0,00'
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
  inherited pnlStatus: TPanel
    Top = 378
    Width = 470
    TabOrder = 4
    ExplicitTop = 378
    ExplicitWidth = 470
    inherited pnlNomeForm: TPanel
      Left = 299
      ExplicitLeft = 299
    end
    inherited pnlInfo: TPanel
      Width = 299
      ExplicitWidth = 299
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 165
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 401
    Top = 165
  end
  object dtsCadTab: TDataSource
    Left = 434
    Top = 198
  end
end
