inherited frmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa: TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa
  Width = 1000
  Height = 391
  Caption = 'Meta de Vendedores por Faturamento + Rentabilidade por Empresa'
  Position = poMainFormCenter
  ExplicitWidth = 1000
  ExplicitHeight = 391
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 318
    Width = 994
    ExplicitTop = 318
    ExplicitWidth = 994
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 128
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 1
        OnClick = btnCopiarMetasClick
      end
      object btnParam: TBitBtnLocked
        Left = 256
        Top = 0
        Width = 129
        Height = 22
        Caption = '[ F12 ] Parametriza'#231#245'es'
        TabOrder = 2
        OnClick = btnParamClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 914
    end
  end
  inherited pnlStatus: TPanel
    Top = 346
    Width = 994
    ExplicitTop = 346
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 644
      Width = 350
      ExplicitLeft = 644
      ExplicitWidth = 350
    end
    inherited pnlInfo: TPanel
      Width = 644
      ExplicitWidth = 644
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 994
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object lblPeriodoAtual: TLabel
      Left = 3
      Top = 10
      Width = 97
      Height = 14
      Caption = 'Per'#237'odo Atual de: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 160
      Top = 10
      Width = 55
      Height = 14
      Caption = 'Empresa: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpCodEmp: TShape
      Left = 218
      Top = 6
      Width = 5
      Height = 22
      Brush.Color = clGreen
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 268
      Top = 6
      Width = 350
      Height = 22
      Alignment = taLeftJustify
      Color = 16770261
      Enabled = False
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object pnlMesAnoOrigem: TPanel
      Left = 739
      Top = 0
      Width = 255
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      TabStop = True
      Visible = False
      object lblCopiarMetasDoPeriodoOrigem: TLabel
        Left = 5
        Top = 10
        Width = 188
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Copiar metas do per'#237'odo de origem:'
      end
      object bvlSeparador: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 196
        Top = 6
        Width = 53
        Height = 22
        EditMask = '99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 6
      Width = 54
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 224
      Top = 6
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
  end
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 35
    Width = 994
    Height = 283
    ActivePage = tbsMetaDeRentabilidadeVendedor
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    TabStop = False
    OnChange = pgcDadosChange
    object tbsMetaDeVendedorFaturamento: TTabSheet
      Caption = 'Meta de Vendedor - Faturamento'
      object cxgMetaVendedorFaturamento: TcxGrid
        Left = 0
        Top = 0
        Width = 986
        Height = 251
        Align = alClient
        TabOrder = 0
        object cxgVendedorFaturamentoView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgVendedorFaturamentoViewEditKeyDown
          DataController.DataSource = dscMetasVendedores
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'FAD_VALFAT'
              Column = cxgVendedorFaturamentoViewVALFAT
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'FAD_PREM01'
              Column = cxgVendedorFaturamentoViewPREM01
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'FAD_PREM02'
              Column = cxgVendedorFaturamentoViewPREM02
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'FAD_PREM03'
              Column = cxgVendedorFaturamentoViewPREM03
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'FAD_PREM04'
              Column = cxgVendedorFaturamentoViewPREM04
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxgVendedorFaturamentoViewCODVEN: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'FAD_CODVEN'
            Options.Editing = False
            Width = 90
          end
          object cxgVendedorFaturamentoViewNOMVEN: TcxGridDBColumn
            Caption = 'Vendedor'
            DataBinding.FieldName = 'NOMVEN'
            Options.Editing = False
            Width = 200
          end
          object cxgVendedorFaturamentoViewNOMFUN: TcxGridDBColumn
            Caption = 'Fun'#231#227'o'
            DataBinding.FieldName = 'NOMFUN'
            Options.Editing = False
            Width = 180
          end
          object cxgVendedorFaturamentoViewVALFAT: TcxGridDBColumn
            Caption = 'Valor do Faturamento'
            DataBinding.FieldName = 'FAD_VALFAT'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 110
          end
          object cxgVendedorFaturamentoViewPREM01: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa abaixo'
            DataBinding.FieldName = 'FAD_PREM01'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 120
          end
          object cxgVendedorFaturamentoViewPREM02: TcxGridDBColumn
            Caption = 'Pr'#234'mio meta atingida'
            DataBinding.FieldName = 'FAD_PREM02'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 120
          end
          object cxgVendedorFaturamentoViewPREM03: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa acima'
            DataBinding.FieldName = 'FAD_PREM03'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 120
          end
          object cxgVendedorFaturamentoViewPREM04: TcxGridDBColumn
            Caption = 'Pr'#234'mio 2 casas acima'
            DataBinding.FieldName = 'FAD_PREM04'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 120
          end
        end
        object cxgVendedorFaturamento: TcxGridLevel
          GridView = cxgVendedorFaturamentoView
        end
      end
    end
    object tbsMetaDeRentabilidadeEmpresa: TTabSheet
      Caption = 'Meta de Rentabilidade - Empresa'
      ImageIndex = 1
      object cxgMetaRentabilidadeEmpresa: TcxGrid
        Left = 0
        Top = 0
        Width = 986
        Height = 251
        Align = alClient
        TabOrder = 0
        object cxgRentabilidadeEmpresaView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgRentabilidadeEmpresaViewEditKeyDown
          DataController.DataSource = dscMetasEmpresas
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'MET_MARGEM'
              Column = cxgRentabilidadeEmpresaViewMARGEM
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'MET_PREMIO'
              Column = cxgRentabilidadeEmpresaViewPREMIO
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxgRentabilidadeEmpresaViewCODEMP: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'MET_CODEMP'
            Options.Editing = False
            Width = 90
          end
          object cxgRentabilidadeEmpresaViewNOMEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'NOMEMP'
            Options.Editing = False
            Width = 300
          end
          object cxgRentabilidadeEmpresaViewMARGEM: TcxGridDBColumn
            Caption = 'Meta Margem'
            DataBinding.FieldName = 'MET_MARGEM'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxgRentabilidadeEmpresaViewPRE1AB: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa abaixo'
            DataBinding.FieldName = 'MET_PRE1AB'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxgRentabilidadeEmpresaViewPREMIO: TcxGridDBColumn
            Caption = 'Pr'#234'mio Renta Atingida'
            DataBinding.FieldName = 'MET_PREMIO'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxgRentabilidadeEmpresaViewPRE1AC: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa acima'
            DataBinding.FieldName = 'MET_PRE1AC'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxgRentabilidadeEmpresaViewPRE2AC: TcxGridDBColumn
            Caption = 'Pr'#234'mio 2 casas acima'
            DataBinding.FieldName = 'MET_PRE2AC'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
        end
        object cxgRentabilidadeEmpresa: TcxGridLevel
          GridView = cxgRentabilidadeEmpresaView
        end
      end
    end
    object tbsPremioRentabilidadeSemAtingirMeta: TTabSheet
      Caption = 'Pr'#234'mio Rentabilidade Sem Atingir Meta'
      ImageIndex = 2
      object dbgSemMeta: TDBGridCitel
        Left = 0
        Top = 0
        Width = 986
        Height = 192
        Align = alClient
        DataSource = dscSemMeta
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgSemMetaDblClick
        OnKeyDown = dbgSemMetaKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'MET_FATINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor de Faturameanto Inicial'
            Width = 160
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MET_FATFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor de Faturameanto Final'
            Width = 160
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MET_PREMIO'
            Title.Alignment = taRightJustify
            Title.Caption = 'Pr'#234'mio'
            Width = 100
            Visible = True
          end>
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 192
        Width = 986
        Height = 59
        Align = alBottom
        TabOrder = 1
        object lblValorInicial: TLabel
          Left = 370
          Top = 12
          Width = 135
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de Faturamento Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblValorFinal: TLabel
          Left = 518
          Top = 12
          Width = 131
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de Faturamento Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPremiacao: TLabel
          Left = 702
          Top = 12
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Premia'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtVlrInicial: TEditFocus
          Tag = 99
          Left = 374
          Top = 27
          Width = 131
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
        object btnAdicionar: TBitBtnLocked
          Left = 761
          Top = 27
          Width = 100
          Height = 22
          Caption = '&Adicionar'
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
        object btnCancelar: TBitBtnLocked
          Left = 862
          Top = 27
          Width = 100
          Height = 22
          Caption = 'Ca&ncelar'
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
          TabOrder = 4
          OnClick = btnCancelarClick
        end
        object edtVlrFinal: TEditFocus
          Tag = 99
          Left = 518
          Top = 27
          Width = 131
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
        object edtVlrPremiacao: TEditFocus
          Tag = 99
          Left = 664
          Top = 27
          Width = 91
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
    end
    object tbsMetaDeRentabilidadeVendedor: TTabSheet
      Caption = 'Meta de Rentabilidade - Vendedor'
      ImageIndex = 3
      object cxgMetaRentabilidadeVendedor: TcxGrid
        Left = 0
        Top = 0
        Width = 986
        Height = 251
        Align = alClient
        TabOrder = 0
        object cxgRentabilidadeVendedorView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = cxgRentabilidadeEmpresaViewEditKeyDown
          DataController.DataSource = dscRentaVendedores
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'MET_MARGEM'
              Column = cxGridDBColumn3
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'MET_PREMIO'
              Column = cxGridDBColumn5
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'MET_CODVEN'
            Options.Editing = False
            Width = 90
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Vendedor'
            DataBinding.FieldName = 'NOMVEN'
            Options.Editing = False
            Width = 300
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Meta Margem'
            DataBinding.FieldName = 'MET_MARGEM'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa abaixo'
            DataBinding.FieldName = 'MET_PRE1AB'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Pr'#234'mio Renta Atingida'
            DataBinding.FieldName = 'MET_PREMIO'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'Pr'#234'mio 1 casa acima'
            DataBinding.FieldName = 'MET_PRE1AC'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Pr'#234'mio 2 casas acima'
            DataBinding.FieldName = 'MET_PRE2AC'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Styles.Content = CorFundoCelulasEditaveis
            Width = 150
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxgRentabilidadeVendedorView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 152
  end
  object dscMetasVendedores: TDataSource
    Left = 376
    Top = 160
  end
  object dscMetasEmpresas: TDataSource
    Left = 376
    Top = 208
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 600
    Top = 152
    PixelsPerInch = 96
    object CorFundoCelulasEditaveis: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
  object dscSemMeta: TDataSource
    DataSet = TSemMeta
    Left = 736
    Top = 208
  end
  object TSemMeta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 736
    Top = 160
    object TSemMetaMET_FATINI: TFloatField
      DisplayLabel = '#,##0.00'
      FieldName = 'MET_FATINI'
      DisplayFormat = '#,##0.00'
    end
    object TSemMetaMET_FATFIN: TFloatField
      DisplayLabel = '#,##0.00'
      FieldName = 'MET_FATFIN'
      DisplayFormat = '#,##0.00'
    end
    object TSemMetaMET_PREMIO: TFloatField
      DisplayLabel = '#,##0.00'
      FieldName = 'MET_PREMIO'
      DisplayFormat = '#,##0.00'
    end
  end
  object dscRentaVendedores: TDataSource
    Left = 504
    Top = 208
  end
end
