inherited frmRelacionamentoClienteProdutoGarantia: TfrmRelacionamentoClienteProdutoGarantia
  Width = 900
  Height = 554
  Caption = 'Relacionamento de Cliente e Produto - Garantia'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 900
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 894
    Height = 26
    Enabled = True
    Visible = True
    ExplicitTop = 483
    ExplicitWidth = 894
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 701
      Top = 6
      Width = 813
      Height = 49
      Align = alNone
      TabOrder = 3
      ExplicitLeft = 701
      ExplicitTop = 6
      ExplicitWidth = 813
      ExplicitHeight = 49
    end
    inherited btnSair: TBitBtnLocked
      Left = 815
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 815
      ExplicitTop = 2
    end
    object btnExcluirRelac: TBitBtnLocked
      Left = 2
      Top = 1
      Width = 195
      Height = 22
      Caption = '[F9] - Excluir Relacionamento'
      TabOrder = 0
      TabStop = False
      OnClick = btnExcluirRelacClick
    end
    object btnManutencao: TBitBtnLocked
      Left = 197
      Top = 1
      Width = 153
      Height = 22
      Caption = '[ F8 ] - Manuten'#231#227'o'
      TabOrder = 1
      TabStop = False
      OnClick = btnManutencaoClick
    end
  end
  inherited pgcDados: TPageControl
    Top = 61
    Width = 894
    Height = 422
    ExplicitTop = 61
    ExplicitWidth = 894
    ExplicitHeight = 422
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 886
      ExplicitHeight = 390
    end
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 894
    ExplicitTop = 509
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object pnlFiltro: TPanel [4]
    Left = 0
    Top = 0
    Width = 894
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label6: TLabel
      Left = 27
      Top = 34
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label8: TLabel
      Left = 32
      Top = 12
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 69
      Top = 30
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnEnter = edtCodIteEnter
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 138
      Top = 30
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 69
      Top = 8
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnEnter = edtCodCliEnter
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 138
      Top = 8
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 579
      Top = 30
      Width = 85
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
      OnClick = btnAdicionarClick
      OnEnter = btnAdicionarEnter
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 664
      Top = 30
      Width = 85
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 5
      OnClick = btnCancelaItemClick
      OnEnter = btnCancelaItemEnter
    end
  end
  object pnlGrid: TPanel [5]
    Left = 0
    Top = 61
    Width = 894
    Height = 422
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object cxgProdutos: TcxGrid
      Left = 0
      Top = 0
      Width = 894
      Height = 422
      Align = alClient
      TabOrder = 0
      OnEnter = cxgProdutosEnter
      object cxvProdutos: TcxGridDBBandedTableView
        OnKeyPress = cxvProdutosKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = cxvProdutosEditKeyPress
        DataController.DataSource = dtsProdutos
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'Cliente'
            Width = 350
          end
          item
            Caption = 'Produto'
            Width = 350
          end
          item
            Width = 110
          end>
        object cxgProdutosCODCLI: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODCLI'
          MinWidth = 21
          Options.Editing = False
          Width = 21
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgProdutosNOMCLI: TcxGridDBBandedColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'NOMCLI'
          Options.Editing = False
          Width = 50
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgProdutosCODITE: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          MinWidth = 21
          Options.Editing = False
          Width = 21
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgProdutosDESITE: TcxGridDBBandedColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 50
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgProdutosCODITC: TcxGridDBBandedColumn
          Caption = 'C'#243'd. Prod. Cliente'
          DataBinding.FieldName = 'CODITC'
          Options.Editing = False
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object cxgProdutosLevel1: TcxGridLevel
        GridView = cxvProdutos
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 56
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 208
    Top = 16
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsProdutos: TDataSource
    Left = 616
    Top = 24
  end
end
