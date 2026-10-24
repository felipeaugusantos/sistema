inherited frmReqEnvioSelDocDevolucao: TfrmReqEnvioSelDocDevolucao
  Caption = 
    'Requisi'#231#227'o de Devolu'#231#227'o de Materiais - Vidro - Item Especial - S' +
    'ervi'#231'o.'
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 435
    Height = 25
    Enabled = True
    Visible = True
    ExplicitTop = 435
    ExplicitHeight = 25
    object lblLegenda: TLabel [0]
      Left = 489
      Top = 7
      Width = 201
      Height = 11
      Caption = '[ESPA'#199'O PARA MARCAR ITEM SELECIONADO]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 484
      Width = 213
      Height = 21
      TabOrder = 5
      ExplicitHeight = 21
    end
    inherited btnSair: TBitBtnLocked
      Left = 697
      Top = 2
      Width = 70
      Height = 21
      Align = alRight
      TabOrder = 4
      ExplicitLeft = 697
      ExplicitTop = 2
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 201
      Top = 2
      Width = 122
      Height = 21
      Align = alLeft
      Caption = '[F7] &Desmarcar Todos'
      TabOrder = 2
      OnClick = btnDesmarcarClick
    end
    object btnMarcar: TBitBtnLocked
      Left = 105
      Top = 2
      Width = 96
      Height = 21
      Align = alLeft
      Caption = '[F6] &Marcar Todos'
      TabOrder = 1
      OnClick = btnMarcarClick
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 103
      Height = 21
      Align = alLeft
      Caption = '[F10] &Confirma'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000040000
        00130000001E0000002000000020000000200000002100000021000000210000
        002200000022000000220000002300000021000000160000000500000012281E
        16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
        3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
        21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
        79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
        24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
        6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
        26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
        EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
        29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
        EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
        2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
        2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
        4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
        32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
        3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
        35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
        CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
        36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
        3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
        39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
        38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
        3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
        36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
        3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
        F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
        2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
        64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
        0002000000030000000400000004000000040000000400000005000000050000
        0005000000050000000500000006000000060000000400000001}
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnConsultaDevolvidos: TBitBtnLocked
      Left = 323
      Top = 2
      Width = 161
      Height = 21
      Align = alLeft
      Caption = '[F8] &Consultar Itens Devolvidos'
      TabOrder = 3
      OnClick = btnConsultaDevolvidosClick
    end
  end
  inherited pgcDados: TPageControl
    Height = 435
    ExplicitHeight = 435
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 403
    end
  end
  inherited pnlStatus: TPanel
    inherited pnlInfo: TPanel
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 0
    Width = 769
    Height = 435
    Align = alClient
    TabOrder = 4
    object cxGridDocumentosEntrada: TcxGridCitel
      Left = 1
      Top = 1
      Width = 767
      Height = 433
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDocumentosEntradaTableView1: TcxGridDBTableViewCitel
        OnKeyDown = cxGridDocumentosEntradaTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridDocumentosEntradaTableView1CustomDrawCell
        DataController.DataSource = dtsDocDevol
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object columnCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo  '
          DataBinding.FieldName = 'DET_CODITE'
          BestFitMaxWidth = 64
          Options.Editing = False
        end
        object columnDesIte: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Item'
          DataBinding.FieldName = 'DET_DESCRI'
          BestFitMaxWidth = 330
          Options.Editing = False
          Width = 265
        end
        object columnReferencia: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'DET_REFERE'
          BestFitMaxWidth = 64
          Options.Editing = False
        end
        object columnUnidade: TcxGridDBColumn
          Caption = 'Und.'
          DataBinding.FieldName = 'DET_UNIDAD'
          BestFitMaxWidth = 35
          Options.Editing = False
          Width = 35
        end
        object columnQtdSaida: TcxGridDBColumn
          Caption = 'Qtd. Sa'#237'da'
          DataBinding.FieldName = 'QTDSAI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Properties.DecimalPlaces = 2
          BestFitMaxWidth = 69
          Options.Editing = False
          Width = 69
        end
        object columnQtdDevolvida: TcxGridDBColumn
          Caption = 'Qtd. Devolvida'
          DataBinding.FieldName = 'QTDDEV'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          BestFitMaxWidth = 90
          Options.Editing = False
          Width = 90
        end
        object columnQtdPendente: TcxGridDBColumn
          Caption = 'Qtd. Pendente'
          DataBinding.FieldName = 'QTDPEN'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          BestFitMaxWidth = 80
          Options.Editing = False
          Width = 80
        end
        object columnQtdaDevolver: TcxGridDBColumn
          Caption = 'Qtd. a Devolver'
          DataBinding.FieldName = 'QTDDEVOLVER'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Properties.DecimalPlaces = 0
          Properties.UseDisplayFormatWhenEditing = True
          Properties.OnValidate = columnQtdaDevolverPropertiesValidate
          BestFitMaxWidth = 90
          Width = 90
        end
        object columnMardes: TcxGridDBColumn
          DataBinding.FieldName = 'MARDES'
          Visible = False
          Options.Editing = False
        end
      end
      object cxGridDocumentosEntradaLevel1: TcxGridLevel
        GridView = cxGridDocumentosEntradaTableView1
      end
    end
  end
  object dtsDocDevol: TDataSource
    Left = 480
    Top = 160
  end
end
