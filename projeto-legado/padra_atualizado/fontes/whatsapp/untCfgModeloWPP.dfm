inherited frmCfgModeloWPP: TfrmCfgModeloWPP
  Width = 1024
  Height = 600
  Caption = 'Configura'#231#227'o do Modelo de Mensagem - Whatsapp'
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 1018
    ExplicitTop = 529
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnRegrasRelatorio: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 142
        Height = 22
        Caption = 'Regras do Relat'#243'rio'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0001000000040000000700000005000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000001000000020000
          00063D29238F714C43FF311F1A8F000000070000000200000001000000000000
          000000000000000000000000000000000000000000010D090723201613552519
          1565715045F3C2B0A7FF5E3F35F3231713671D1310570B070625000000000000
          00000000000000000000000000000000000000000002523B32B7987F76FF8467
          5DFFBFAEA4FFE2D9D2FFC6B7B1FF7D5F56FF896D63FF472F28B90000000B0000
          001100000012000000120000001200000012000000133C2C2780A48A80FFECE7
          E3FFBDA69CFF9E7E70FFC3AFA6FFEAE2DEFF997C72FF38282479714F44C29E6D
          5DFF9E6C5DFF9D6C5CFF9D6B5BFF9C6C5CFFBE9E94FFE1D6D2FF8D6C5EFFEAE4
          E0FF8B6B5FFFF7EEEAFF8B6B60FFE7DFD9FF765549FC00000008A17162FFF9F2
          EFFFF7EEE9FFF7EEEAFFC29F93FFF7EEE9FFFAF6F4FFC8B7B0FFAC9388FFEFEA
          E6FFB19E98FF755349FFAC978FFFE9E1DCFFA1887EFF3A2A257AA47567FFF9F2
          F0FFF7EEEBFFF7EEEAFFC3A095FFF7EEEAFFFBF6F4FFB8A096FFB7A095FFA88A
          7FFFD9CDC7FFF6F3F1FFD4C5BEFFA4877AFFB1998EFF675045B63137BBFF2F36
          BAFF2D34B8FF2C33B7FF2B31B6FFC3A196FFE3D3CEFFE6DAD6FFD7C6C1FFD4C4
          BEFFA38375FFE2D8D2FF9B7A6DFF3127225D30252151120E0C213E49C5FF778C
          FBFF657BF9FF647AFAFF373FC1FFF8EFEBFFF8F1EDFFFAF3F0FFD2B9B0FFFCF9
          F8FFCDBAB2FFA28273FFC0A99FFF0000000E0000000000000000434ECAFF798E
          FBFF778CFAFF758AFBFF3E48C6FFF8F0EDFFF8F0ECFFF8F0ECFFC5A499FFFAF6
          F4FFFDFBFAFFFEFCFBFFE9DEDAFF0000000C00000000000000004450CBFF4E59
          CEFF4E59CEFF4D59CDFF305DC3FF2466BEFF2363BCFF2361BBFF215FBAFFC7A6
          9BFFC6A69AFFD4B9B0FFAD8071FF0000000A0000000000000000B78E81FFFAF5
          F2FFF8F0EEFFF7F1EEFF2973C4FFB7E6FAFF74CFF6FF73CFF6FF2468BFFFF7F0
          EEFFF8F0EDFFFAF4F2FFB08577FF000000090000000000000000BA9285FFFAF5
          F2FFFAF5F2FFFAF5F2FF2D7CCAFFBBE9FBFFBBE9FBFFBBE9FAFF2A72C4FFFAF4
          F2FFFAF5F2FFFAF5F2FFB48A7CFF0000000800000000000000008C7065C1BE97
          89FFBC9688FFBC9588FF3084CDFF3082CDFF2E7FCBFF2D7ECAFF2C7CCAFFBA91
          83FFB89083FFB88F82FF876A5FC1000000050000000000000000000000030000
          0005000000050000000500000005000000050000000500000005000000060000
          0006000000060000000500000004000000010000000000000000}
        TabOrder = 1
        OnClick = btnRegrasRelatorioClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlCamDis: TPanel [2]
    Left = 0
    Top = 0
    Width = 185
    Height = 529
    Align = alLeft
    Caption = 'pnlCamDis'
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 183
      Height = 527
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGrid1DBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        OnKeyDown = cxGrid1DBBandedTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGrid1DBBandedTableViewCitel1CellDblClick
        DataController.DataSource = dtsCamDis
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.Background = cxStyle2
        Bands = <
          item
            Caption = 'Campos Dispon'#237'veis'
            Styles.Header = cxStyle1
          end>
        Zebra = True
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
        object cxGrid1DBBandedTableViewCitel1Column1: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CAMDIS'
          SortIndex = 0
          SortOrder = soAscending
          Width = 180
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
          IsCaptionAssigned = True
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBBandedTableViewCitel1
      end
    end
  end
  object pnlFundo: TPanel [3]
    Left = 185
    Top = 0
    Width = 833
    Height = 529
    Align = alClient
    TabOrder = 3
    object pnlEditor: TPanel
      Left = 1
      Top = 1
      Width = 831
      Height = 527
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object mmoMensagem: TMemoFocus
        Left = 1
        Top = 25
        Width = 829
        Height = 483
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = mmoMensagemChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object pnlContagem: TPanel
        Left = 1
        Top = 508
        Width = 829
        Height = 18
        Align = alBottom
        BevelOuter = bvNone
        BorderWidth = 1
        Caption = 'A mensagem ter'#225' 000 caracretes aproximadamente'
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object pnlSuperior: TPanel
        Left = 1
        Top = 1
        Width = 829
        Height = 24
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          829
          24)
        object chkEnvDoc: TCheckBox
          Left = 679
          Top = 4
          Width = 145
          Height = 16
          Anchors = [akTop, akRight]
          Caption = 'Enviar PDF do Documento'
          TabOrder = 0
          Visible = False
        end
        object btnConfiguraEmailPedidoCompraPDF: TBitBtnLocked
          Left = 441
          Top = 0
          Width = 232
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Definir Par'#226'metros PDF Pedido de Compra'
          TabOrder = 1
          Visible = False
          OnClick = btnConfiguraEmailPedidoCompraPDFClick
        end
        object pnlAnexo: TPanel
          Left = 137
          Top = 1
          Width = 215
          Height = 22
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          ExplicitLeft = 9
          ExplicitTop = 2
          object lblCaminhoImagem: TLabel
            Left = 2
            Top = 3
            Width = 113
            Height = 14
            Caption = 'Caminho da Imagem'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object btnAnexarImagem: TBitBtnLocked
            Left = 121
            Top = 0
            Width = 87
            Height = 22
            Caption = 'Anexar Imagem'
            TabOrder = 0
            OnClick = btnAnexarImagemClick
          end
        end
        object pnlTemplateID: TPanel
          Left = 1
          Top = 1
          Width = 136
          Height = 22
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 3
          ExplicitLeft = 9
          ExplicitTop = 2
          object lblTemplateID: TLabel
            Left = 5
            Top = 3
            Width = 64
            Height = 14
            Caption = 'Template ID'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtTemplateID: TEditFocus
            Left = 73
            Top = 1
            Width = 56
            Height = 21
            Alignment = taLeftJustify
            AutoSize = False
            TabOrder = 0
            Text = '0'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
      end
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 528
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
  end
  object dtsCamDis: TDataSource
    Left = 80
    Top = 256
  end
end
