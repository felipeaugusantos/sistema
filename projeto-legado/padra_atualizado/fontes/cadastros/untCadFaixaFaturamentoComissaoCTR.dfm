inherited frmCadFaixaFaturamentoComissaoCTR: TfrmCadFaixaFaturamentoComissaoCTR
  Left = 244
  Top = 135
  Width = 426
  Height = 336
  Caption = 'Faixa de faturamento para comiss'#227'o de vendedores'
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 426
  ExplicitHeight = 336
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 265
    Width = 420
    Height = 26
    TabOrder = 1
    ExplicitTop = 265
    ExplicitWidth = 420
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 92
      Width = 249
      Height = 22
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 416
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 341
      Top = 2
      Align = alRight
      ExplicitLeft = 336
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 90
      Height = 22
      Align = alLeft
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
      ExplicitLeft = 6
      ExplicitTop = 3
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 420
    Height = 265
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 263
    object pnlGrid: TPanel
      Left = 1
      Top = 51
      Width = 418
      Height = 213
      Align = alClient
      Color = 16770261
      TabOrder = 1
      ExplicitHeight = 211
      object Label12: TLabel
        Left = 7
        Top = 192
        Width = 228
        Height = 14
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object dbgCadFct: TDBGridCitel
        Left = 1
        Top = 1
        Width = 416
        Height = 190
        Align = alTop
        DataSource = dtsCadFct
        Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgCadFctDblClick
        OnKeyDown = dbgCadFctKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'FATINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Inicial'
            Width = 145
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FATFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Faturamento Final'
            Width = 145
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PERCEN'
            Title.Alignment = taRightJustify
            Title.Caption = '% Comiss'#227'o'
            Width = 100
            Visible = True
          end>
      end
    end
    object pnlCentro: TPanel
      Left = 1
      Top = 1
      Width = 418
      Height = 50
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label5: TLabel
        Left = 6
        Top = 8
        Width = 89
        Height = 14
        Caption = 'Faturamento Inicial'
      end
      object Label6: TLabel
        Left = 128
        Top = 8
        Width = 85
        Height = 14
        Caption = 'Faturamento Final'
      end
      object Label7: TLabel
        Left = 250
        Top = 8
        Width = 60
        Height = 14
        Caption = '% Comiss'#227'o'
      end
      object edtFatIni: TEditFocus
        Tag = 99
        Left = 6
        Top = 22
        Width = 120
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
      object edtFatFin: TEditFocus
        Tag = 99
        Left = 128
        Top = 22
        Width = 120
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
      object edtPercen: TEditFocus
        Tag = 99
        Left = 250
        Top = 22
        Width = 60
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
      object btnAdicionar: TBitBtnLocked
        Left = 316
        Top = 22
        Width = 72
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
        TabOrder = 3
        OnClick = btnAdicionarClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 291
    Width = 420
    TabOrder = 2
    ExplicitTop = 291
    ExplicitWidth = 420
    inherited pnlNomeForm: TPanel
      Left = 249
      TabOrder = 1
      ExplicitLeft = 249
    end
    inherited pnlInfo: TPanel
      Width = 249
      TabOrder = 0
      ExplicitWidth = 249
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 832
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 8
  end
  object dtsCadFct: TDataSource
    DataSet = cdsCadFct
    Left = 343
    Top = 100
  end
  object cdsCadFct: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsCadFctAfterPost
    Left = 373
    Top = 100
    object cdsCadFctID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsCadFctFATINI: TFloatField
      FieldName = 'FATINI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsCadFctFATFIN: TFloatField
      FieldName = 'FATFIN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsCadFctPERCEN: TFloatField
      FieldName = 'PERCEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
end
