inherited frmImportCadEstruturaConfirma: TfrmImportCadEstruturaConfirma
  Width = 880
  Height = 581
  BorderStyle = bsSingle
  Caption = 'Importa'#231#227'o de Cadastro de Estrutura - Confirma'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 880
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 874
    ExplicitTop = 510
    ExplicitWidth = 874
    inherited FlwBotoes: TFlowPanel
      Width = 870
      ExplicitTop = 2
      ExplicitWidth = 870
    end
    inherited btnSair: TBitBtnLocked
      Left = 794
      ExplicitLeft = 794
    end
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 874
    ExplicitTop = 536
    ExplicitWidth = 874
    inherited pnlNomeForm: TPanel
      Left = 703
      ExplicitLeft = 703
    end
    inherited pnlInfo: TPanel
      Width = 703
      ExplicitWidth = 703
    end
  end
  object cxGrid1: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 874
    Height = 440
    Align = alClient
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Visible = True
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = True
      DataController.DataSource = dtsGerMat
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'GMT_CODITE'
        MinWidth = 64
        Width = 70
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
      end
      object cxGrid1DBTableView1Column8: TcxGridDBColumn
        Caption = 'Tipo de Quantidade'
        DataBinding.FieldName = 'GMT_TIPQTD '
        OnGetDisplayText = cxGrid1DBTableView1Column8GetDisplayText
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = 'Observa'#231#227'o 1'
        DataBinding.FieldName = 'GMT_OBS001'
      end
      object cxGrid1DBTableView1Column5: TcxGridDBColumn
        Caption = 'Observa'#231#227'o 2'
        DataBinding.FieldName = 'GMT_OBS002'
      end
      object cxGrid1DBTableView1Column6: TcxGridDBColumn
        Caption = 'Observa'#231#227'o 3'
        DataBinding.FieldName = 'GMT_OBS003'
      end
      object cxGrid1DBTableView1Column7: TcxGridDBColumn
        Caption = 'Observa'#231#227'o 4'
        DataBinding.FieldName = 'GMT_OBS004'
      end
    end
    object cxGrid1DBTableView2: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Visible = True
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = True
      OnCustomDrawCell = cxGrid1DBTableView2CustomDrawCell
      DataController.DataSource = dtsDetMat
      DataController.DetailKeyFieldNames = 'DMT_SEQGER'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.MasterKeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDetDMT_ITESUB: TcxGridDBColumn
        Caption = 'Sub-Item'
        DataBinding.FieldName = 'DMT_ITESUB'
        MinWidth = 64
        Width = 70
      end
      object cxgDetDMT_SEQUEN: TcxGridDBColumn
        Caption = 'Seq.'
        DataBinding.FieldName = 'DMT_SEQUEN'
        HeaderAlignmentHorz = taRightJustify
        Width = 20
      end
      object cxgDetITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
      end
      object cxgDetITE_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
      end
      object cxgDetMat_ACAO: TcxGridDBColumn
        DataBinding.FieldName = 'ACAO'
        Visible = False
      end
      object cxgDetDMT_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'DMT_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.000000;0.000000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_DESPCA: TcxGridDBColumn
        Caption = 'Destino'
        DataBinding.FieldName = 'DMT_DESPCA'
      end
      object cxgDetDMT_APAREL: TcxGridDBColumn
        Caption = 'Aparelhada'
        DataBinding.FieldName = 'DMT_APAREL'
      end
      object cxgDetDMT_ACUMOP: TcxGridDBColumn
        Caption = 'Acumula na OP'
        DataBinding.FieldName = 'DMT_ACUMOP'
      end
      object cxgDetDMT_BENEFI: TcxGridDBColumn
        Caption = 'Benefic.'
        DataBinding.FieldName = 'DMT_BENEFI'
      end
      object cxgDetDMT_COMPEC: TcxGridDBColumn
        Caption = 'Comprim'
        DataBinding.FieldName = 'DMT_COMPEC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_ESPPEC: TcxGridDBColumn
        Caption = 'Espessura'
        DataBinding.FieldName = 'DMT_ESPPEC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_LARPEC: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'DMT_LARPEC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_PERAPA: TcxGridDBColumn
        Caption = 'Acr. Aparel'
        DataBinding.FieldName = 'DMT_PERAPA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_PERBEN: TcxGridDBColumn
        Caption = 'Acr. Benefic'
        DataBinding.FieldName = 'DMT_PERBEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgDetDMT_QTDPEC: TcxGridDBColumn
        Caption = 'Quantidade Pe'#231'a'
        DataBinding.FieldName = 'DMT_QTDPEC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00000'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
      object cxGrid1Level2: TcxGridLevel
        GridView = cxGrid1DBTableView2
      end
    end
  end
  object GroupBox1: TGroupBox [4]
    Left = 0
    Top = 440
    Width = 874
    Height = 70
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 4
    object Shape1: TShape
      Left = 8
      Top = 18
      Width = 17
      Height = 15
      Brush.Color = clMoneyGreen
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 17
      Height = 15
      Brush.Color = clYellow
    end
    object Shape3: TShape
      Left = 8
      Top = 50
      Width = 17
      Height = 15
      Brush.Color = clAqua
    end
    object Label1: TLabel
      Left = 31
      Top = 18
      Width = 154
      Height = 14
      Caption = 'Item da Estrutura Sem Altera'#231#227'o'
    end
    object Label2: TLabel
      Left = 31
      Top = 34
      Width = 171
      Height = 14
      Caption = 'Item da Estrutura que Ser'#225' Alterado'
    end
    object Label3: TLabel
      Left = 31
      Top = 50
      Width = 109
      Height = 14
      Caption = 'Item Novo na Estrutura'
    end
  end
  object dtsGerMat: TDataSource
    Left = 56
    Top = 32
  end
  object dtsDetMat: TDataSource
    Left = 56
    Top = 80
  end
end
