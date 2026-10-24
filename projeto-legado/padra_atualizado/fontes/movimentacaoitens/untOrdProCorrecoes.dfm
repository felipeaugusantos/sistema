inherited frmOrdProCorrecoes: TfrmOrdProCorrecoes
  Left = 401
  Top = 270
  Width = 876
  Height = 414
  BorderIcons = [biSystemMenu]
  Caption = 'Corre'#231#245'es da ordem de produ'#231#227'o'
  Position = poScreenCenter
  ExplicitWidth = 876
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 870
    TabOrder = 1
    ExplicitTop = 341
    ExplicitWidth = 870
    object lblInfoDel: TLabel [0]
      AlignWithMargins = True
      Left = 492
      Top = 7
      Width = 65
      Height = 19
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Align = alLeft
      Caption = '[DEL] Apaga'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 14
    end
    inherited FlwBotoes: TFlowPanel
      Left = 557
      Width = 234
      ExplicitLeft = 557
      ExplicitWidth = 234
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 791
      Top = 2
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 791
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 100
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[ F10 ] Confirmar'
      ModalResult = 1
      TabOrder = 1
      Visible = False
    end
    object btnMarTodosEstoque: TBitBtnLocked
      AlignWithMargins = True
      Left = 102
      Top = 2
      Width = 195
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[F4] Marcar todos como estoque'
      TabOrder = 3
      Visible = False
      OnClick = btnMarTodosEstoqueClick
    end
    object btnMarTodosRefugo: TBitBtnLocked
      AlignWithMargins = True
      Left = 297
      Top = 2
      Width = 195
      Height = 24
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[F5] Marcar todos como refugo'
      TabOrder = 4
      Visible = False
      OnClick = btnMarTodosRefugoClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 369
    Width = 870
    TabOrder = 2
    ExplicitTop = 369
    ExplicitWidth = 870
    inherited pnlNomeForm: TPanel
      Left = 699
      ExplicitLeft = 699
    end
    inherited pnlInfo: TPanel
      Width = 699
      ExplicitWidth = 699
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 870
    Height = 341
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object pnlProdutos: TPanel
      Left = 1
      Top = 1
      Width = 868
      Height = 57
      Align = alTop
      Color = 16770261
      Enabled = False
      TabOrder = 0
      object Label1: TLabel
        Left = 9
        Top = 9
        Width = 86
        Height = 14
        Caption = 'Produto Acabado:'
      end
      object Label5: TLabel
        Left = 40
        Top = 32
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Referencia:'
      end
      object Label10: TLabel
        Left = 232
        Top = 32
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object lblCodFabrica: TLabel
        Left = 329
        Top = 32
        Width = 64
        Height = 14
        Caption = 'C'#243'd. F'#225'brica:'
      end
      object edtDesProduto: TEditFocus
        Left = 151
        Top = 5
        Width = 682
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtProdutos: TEditFocus
        Tag = 99
        Left = 99
        Top = 5
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtReferencia: TEditFocus
        Left = 99
        Top = 28
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidade: TEditFocus
        Left = 275
        Top = 28
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFab: TEditFocus
        Left = 399
        Top = 28
        Width = 114
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object cxGridDados: TcxGrid
      Left = 1
      Top = 58
      Width = 868
      Height = 282
      Align = alClient
      TabOrder = 1
      object cxGridDadosDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        OnCustomDrawGroupCell = cxGridDadosDBTableViewCustomDrawGroupCell
        object cxGridDadosDBTableViewCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'ITE_CODITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGridDadosDBTableViewDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'ITE_DESITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 393
        end
        object cxGridDadosDBTableViewCODFAB: TcxGridDBColumn
          Caption = 'C'#243'digo de f'#225'brica'
          DataBinding.FieldName = 'ITE_CODFAB'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 104
        end
        object cxGridDadosDBTableViewREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'ITE_REFERE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGridDadosDBTableViewDESFAS: TcxGridDBColumn
          DataBinding.FieldName = 'DESFAS'
          Visible = False
          GroupIndex = 0
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          IsCaptionAssigned = True
        end
        object cxGridDadosDBTableViewQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'DOP_QTDITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object cxGridDadosDBTableViewITE_DESTIN: TcxGridDBColumn
          Caption = 'Destino'
          DataBinding.FieldName = 'ITE_DESTIN'
          PropertiesClassName = 'TcxRadioGroupProperties'
          Properties.Columns = 2
          Properties.DefaultValue = 'E'
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Estoque'
              Value = 'E'
            end
            item
              Caption = 'Refugo'
              Value = 'R'
            end>
          HeaderAlignmentHorz = taCenter
          Width = 163
        end
      end
      object cxGridDadosLevel1: TcxGridLevel
        GridView = cxGridDadosDBTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 8
  end
end
