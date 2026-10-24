inherited frmImportarListaDeMateriais: TfrmImportarListaDeMateriais
  Width = 1024
  Height = 574
  Caption = 'Importar Lista de Materiais'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 574
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 1018
    Height = 33
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 16770261
    ExplicitTop = 496
    ExplicitWidth = 1018
    ExplicitHeight = 33
    inherited FlwBotoes: TFlowPanel
      Left = 111
      Top = 0
      Width = 796
      Height = 33
      ParentColor = True
      TabOrder = 2
      ExplicitLeft = 111
      ExplicitTop = 0
      ExplicitWidth = 796
      ExplicitHeight = 33
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 45
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblParaLocalizar: TLabel
          Left = 2
          Top = 1
          Width = 125
          Height = 14
          Caption = '[ENTER] Para LOCALIZAR'
        end
        object lblRemover: TLabel
          Left = 2
          Top = 17
          Width = 103
          Height = 14
          Caption = '[DEL] Para REMOVER'
        end
        object lblNaoLocalizado: TLabel
          Left = 171
          Top = 1
          Width = 88
          Height = 14
          Caption = 'N'#227'o Localizado(s)'
        end
        object Label5: TLabel
          Left = 171
          Top = 17
          Width = 503
          Height = 14
          Caption = 
            'Itens Encontrado , mas o c'#243'digo de f'#225'brica pertence a fornecedor' +
            'es distintos - Duplo Clique para alterar.'
        end
        object Shape3: TShape
          Left = 151
          Top = 17
          Width = 14
          Height = 14
          Brush.Color = clBlue
        end
        object shpNaoLocalizado: TShape
          Left = 151
          Top = 1
          Width = 14
          Height = 14
          Brush.Color = clRed
          Pen.Mode = pmMask
        end
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 907
      Top = 0
      Width = 111
      Height = 33
      Align = alRight
      ExplicitLeft = 907
      ExplicitTop = 0
      ExplicitWidth = 111
      ExplicitHeight = 33
    end
    object btnImportar: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 111
      Height = 33
      Align = alLeft
      Caption = '[ F12 ] Importar'
      Enabled = False
      TabOrder = 0
      OnClick = btnImportarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 529
    Width = 1018
    ExplicitTop = 529
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
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 57
    Align = alTop
    ParentColor = True
    TabOrder = 3
    object lblArquivo: TLabel
      Left = 321
      Top = 21
      Width = 41
      Height = 14
      Caption = 'Arquivo:'
    end
    object edtPath: TEdit
      Left = 368
      Top = 18
      Width = 594
      Height = 22
      TabOrder = 0
    end
    object btnImportarArqTxt: TBitBtnLocked
      Left = 968
      Top = 18
      Width = 42
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnImportarArqTxtClick
    end
  end
  object pnlCentro: TPanel [4]
    Left = 0
    Top = 57
    Width = 1018
    Height = 417
    Align = alClient
    TabOrder = 4
    ExplicitHeight = 418
    object cxgListMat: TcxGrid
      Left = 1
      Top = 1
      Width = 1016
      Height = 415
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 416
      object cxgListMatDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        Bands = <
          item
            Caption = 'Autcom'
          end>
        Zebra = False
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
        object cxgListMatDBBandedTableViewCitel1Column1: TcxGridDBBandedColumn
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel1Column2: TcxGridDBBandedColumn
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel1Column3: TcxGridDBBandedColumn
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
      end
      object cxgListMatDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel
        OnDblClick = cxgListMatDBBandedTableViewCitel2DblClick
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgListMatDBBandedTableViewCitel2CustomDrawCell
        DataController.DataSource = dscDados
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
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'ARQUIVO'
          end
          item
            Caption = 'AUTCOM'
            FixedKind = fkRight
          end>
        Zebra = False
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
        object cxgListMatDBBandedTableViewCitel2ARQ_CODFAB: TcxGridDBBandedColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'ARQ_CODFAB'
          HeaderAlignmentHorz = taCenter
          Width = 100
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2ARQ_DESITE: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'ARQ_DESITE'
          Width = 200
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2ARQ_QTDITE: TcxGridDBBandedColumn
          Caption = 'Qtde.'
          DataBinding.FieldName = 'ARQ_QTDITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 65
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2ARQ_PRCITE: TcxGridDBBandedColumn
          Caption = 'Pre'#231'o'
          DataBinding.FieldName = 'ARQ_PRCITE'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 75
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_CODITE: TcxGridDBBandedColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
          HeaderAlignmentHorz = taCenter
          Width = 70
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_DESITE: TcxGridDBBandedColumn
          Caption = 'Descr. Item'
          DataBinding.FieldName = 'DESITE'
          Width = 200
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_UNIDAD: TcxGridDBBandedColumn
          Caption = 'UN'
          DataBinding.FieldName = 'SIGUNI'
          HeaderAlignmentHorz = taCenter
          Width = 40
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_QTDITE: TcxGridDBBandedColumn
          Caption = 'Qtde.'
          DataBinding.FieldName = 'QTDIMP'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_PRCITE: TcxGridDBBandedColumn
          Caption = 'Pre'#231'o'
          DataBinding.FieldName = 'AUT_PRCITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 75
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2AUT_SALDIS: TcxGridDBBandedColumn
          Caption = 'Saldo Disponivel'
          DataBinding.FieldName = 'SALDIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000'
          HeaderAlignmentHorz = taRightJustify
          Width = 90
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgListMatDBBandedTableViewCitel2IDENTIFICADO: TcxGridDBBandedColumn
          Caption = 'Localizou'
          DataBinding.FieldName = 'IDENTIFICADO'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
      end
      object cxgListMatLevel: TcxGridLevel
        GridView = cxgListMatDBBandedTableViewCitel2
      end
    end
  end
  object rdgTipoLayout: TRadioGroup [5]
    Left = 8
    Top = 5
    Width = 305
    Height = 35
    Caption = 'Selecione o Fornecedor'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Deceuninck'
      'Kommerling')
    TabOrder = 5
    StyleElements = [seFont, seBorder]
  end
  object ggProcessamento: TcxProgressBar [6]
    Left = 0
    Top = 474
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 475
    Width = 1018
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 928
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 888
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 848
    Top = 312
  end
  object dscDados: TDataSource
    Left = 928
    Top = 240
  end
  object OpenDialog: TOpenDialog
    Filter = 'Arquivos TXT|*.txt'
    Title = 'Selecione o Arquivo (Lista de Materiais)'
    Left = 928
    Top = 145
  end
end
