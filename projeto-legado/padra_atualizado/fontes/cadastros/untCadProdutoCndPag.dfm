inherited frmCadProdutosCndPag: TfrmCadProdutosCndPag
  Width = 623
  Height = 534
  Caption = 'Produtos x Condi'#231#227'o de Pagamento'
  ExplicitWidth = 623
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 465
    Width = 617
    Height = 25
    ExplicitTop = 465
    ExplicitWidth = 617
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 613
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 613
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 529
      Height = 20
      ExplicitLeft = 529
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 617
    Height = 465
    ExplicitWidth = 617
    ExplicitHeight = 465
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 609
      ExplicitHeight = 433
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 617
    Height = 465
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object pnlDescri: TPanel
      Left = 1
      Top = 1
      Width = 615
      Height = 50
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object Label2: TLabel
        Left = 64
        Top = 20
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label3: TLabel
        Left = 195
        Top = 19
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CRU_CODIGO'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 248
        Top = 15
        Width = 357
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CRU_DESCRI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlLinGru: TPanel
      Left = 1
      Top = 51
      Width = 615
      Height = 207
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 38
        Top = 20
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha/Grupo:'
      end
      object cxgCruGru: TcxGrid
        Left = 1
        Top = 50
        Width = 613
        Height = 156
        Align = alBottom
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCruGruDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgCruGruDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCruGru
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsWhite
          Styles.ContentOdd = cxsGreen
          object cxgCruGruDBTableView1Column1: TcxGridDBColumn
            Caption = 'Linha/Grupo'
            DataBinding.FieldName = 'GRU_CODGRU'
            Width = 80
          end
          object cxgCruGruDBTableView1Column2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'GRU_DESGRU'
            Width = 510
          end
        end
        object cxgCruGruLevel1: TcxGridLevel
          GridView = cxgCruGruDBTableView1
        end
      end
      object edtLinDes: TEditFocus
        Left = 177
        Top = 16
        Width = 320
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnAddLin: TBitBtnLocked
        Left = 505
        Top = 16
        Width = 100
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
        TabOrder = 2
        OnClick = btnAddLinClick
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = ''
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object pnlCndPag: TPanel
      Left = 1
      Top = 258
      Width = 615
      Height = 206
      Align = alBottom
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 2
      object Label4: TLabel
        Left = 13
        Top = 20
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagamento:'
      end
      object cxgCruCnd: TcxGrid
        Left = 1
        Top = 49
        Width = 613
        Height = 156
        Align = alBottom
        TabOrder = 3
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableView1: TcxGridDBTableView
          OnKeyDown = cxGridDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCruCnd
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsWhite
          Styles.ContentOdd = cxsGreen
          object cxGridDBTableView1Column1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CND_CODCND'
            Width = 60
          end
          object cxGridDBTableView1Column2: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CND_DESCRI'
            Width = 250
          end
          object cxGridDBTableView1Column3: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'CND_CNDPAG'
            Width = 280
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
      object edtDesCnd: TEditFocus
        Left = 177
        Top = 16
        Width = 320
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnAddCnd: TBitBtnLocked
        Left = 505
        Top = 16
        Width = 100
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
        TabOrder = 2
        OnClick = btnAddCndClick
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 101
        Top = 16
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 490
    Width = 617
    ExplicitTop = 490
    ExplicitWidth = 617
    inherited pnlNomeForm: TPanel
      Left = 440
      Width = 177
      ExplicitLeft = 440
      ExplicitWidth = 177
    end
    inherited pnlInfo: TPanel
      Width = 440
      ExplicitWidth = 440
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 129
    Top = 392
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 97
    Top = 392
  end
  object dtsCruCnd: TDataSource
    DataSet = cdsCruCnd
    Left = 161
    Top = 360
  end
  object cdsCruCnd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCruCnd'
    Left = 129
    Top = 360
  end
  object dtsTabela: TDataSource
    Left = 161
    Top = 392
  end
  object cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    object cxsWhite: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object cxsGreen: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object cdsCruGru: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCruGru'
    Left = 130
    Top = 328
  end
  object dtsCruGru: TDataSource
    DataSet = cdsCruGru
    Left = 162
    Top = 328
  end
  object dspCruGru: TUniDataSetProvider
    Options = []
    Left = 97
    Top = 328
  end
  object dspCruCnd: TUniDataSetProvider
    Options = []
    Left = 98
    Top = 360
  end
end
