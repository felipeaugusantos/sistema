inherited frmProdutoRessarcimentoIcmsStCAT: TfrmProdutoRessarcimentoIcmsStCAT
  Width = 704
  Height = 692
  Caption = 'Ressarcimento de ICMS e ST de Produto atrav'#233's de CAT'
  OnDestroy = FormDestroy
  ExplicitWidth = 704
  ExplicitHeight = 692
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 619
    Width = 698
    ExplicitTop = 619
    ExplicitWidth = 698
    inherited FlwBotoes: TFlowPanel
      Width = 694
      ExplicitTop = 2
      ExplicitWidth = 694
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 611
      ExplicitLeft = 611
    end
  end
  inherited pnlStatus: TPanel
    Top = 647
    Width = 698
    ExplicitTop = 647
    ExplicitWidth = 698
    inherited pnlNomeForm: TPanel
      Left = 527
      ExplicitLeft = 527
    end
    inherited pnlInfo: TPanel
      Width = 527
      ExplicitWidth = 527
    end
  end
  object cxgAbrev: TcxGrid [3]
    Left = 0
    Top = 35
    Width = 698
    Height = 584
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgAbrevTableView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.GroupByBox = False
      Bands = <
        item
          Width = 70
        end
        item
          Caption = 'ICMS'
          Styles.Content = cxsIcms
          Width = 108
        end
        item
          Caption = 'SUBST. TRIBUT'#193'RIA'
          Styles.Content = cxsST
          Width = 157
        end
        item
          Caption = 'IPI'
        end
        item
          Caption = 'RESSARCIMENTO CAT'
          Styles.Content = cxsRessarcimento
          Width = 208
        end>
      object cxgAbrevDBColUF: TcxGridDBBandedColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CAT_ESTADO'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 37
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgAbrevDBColCodSit: TcxGridDBBandedColumn
        Caption = 'CST'
        DataBinding.FieldName = 'CAT_CODSIT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 26
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgAbrevDBColBasIcm: TcxGridDBBandedColumn
        Caption = '% BASE'
        DataBinding.FieldName = 'CAT_BASICM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 47
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgAbrevDBColAlqIcm: TcxGridDBBandedColumn
        Caption = '% AL'#205'Q.'
        DataBinding.FieldName = 'CAT_ALQICM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 45
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgAbrevDBColBasRet: TcxGridDBBandedColumn
        Caption = '%  BASE'
        DataBinding.FieldName = 'CAT_BASRET'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 54
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgAbrevDBColAlqRet: TcxGridDBBandedColumn
        Caption = '% ALQ. INT.'
        DataBinding.FieldName = 'CAT_ALQRET'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 65
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgAbrevDBColIVA_ST: TcxGridDBBandedColumn
        Caption = 'IVA'
        DataBinding.FieldName = 'CAT_IVA_ST'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 46
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgAbrevTableViewColumn1: TcxGridDBBandedColumn
        Caption = '%IPI'
        DataBinding.FieldName = 'IPIENT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 45
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgAbrevDBColResIcm: TcxGridDBBandedColumn
        Caption = '% RESS.ICMS'
        DataBinding.FieldName = 'CAT_RESICM'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgAbrevDBColRes_St: TcxGridDBBandedColumn
        Caption = '% RESS.ST'
        DataBinding.FieldName = 'CAT_RES_ST'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 64
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgAbrevDBColResTot: TcxGridDBBandedColumn
        Caption = '% RESS.TOT'
        DataBinding.FieldName = 'CAT_RESTOT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Width = 69
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgAbrevLevel: TcxGridLevel
      GridView = cxgAbrevTableView
    end
  end
  object pnlHeader: TPanel [4]
    Tag = 99
    Left = 0
    Top = 0
    Width = 698
    Height = 35
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 10
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 60
      Top = 7
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
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
      Left = 131
      Top = 7
      Width = 558
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
  end
  object cxStyle: TcxStyleRepository
    Left = 416
    Top = 96
    PixelsPerInch = 96
    object cxsIcms: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsST: TcxStyle
      AssignedValues = [svColor]
      Color = 10944511
    end
    object cxsRessarcimento: TcxStyle
      AssignedValues = [svColor]
      Color = 16427478
    end
    object cxsDesconto: TcxStyle
      AssignedValues = [svColor]
      Color = 13434828
    end
  end
end
