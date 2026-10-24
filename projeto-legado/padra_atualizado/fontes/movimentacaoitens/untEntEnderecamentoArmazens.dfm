inherited frmEntEnderecamentoArmazens: TfrmEntEnderecamentoArmazens
  Width = 852
  Height = 458
  BorderStyle = bsSizeable
  Caption = ''
  ExplicitWidth = 852
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 836
    TabOrder = 1
    ExplicitTop = 377
    ExplicitWidth = 836
    inherited FlwBotoes: TFlowPanel
      Width = 755
      ExplicitWidth = 755
      inherited btnConfirma: TBitBtnLocked
        Width = 117
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 117
      end
      object btnCadRapLotWMS: TBitBtnLocked
        Left = 117
        Top = 0
        Width = 146
        Height = 22
        Align = alLeft
        Caption = '[F8] Cad. R'#225'pido Lotes'
        TabOrder = 1
        OnClick = btnCadRapLotWMSClick
      end
      object btnLocFis: TBitBtnLocked
        Left = 263
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F7] Cad. Loc. F'#237'sicas'
        TabOrder = 2
        OnClick = btnLocFisClick
      end
      object btnAtualizar: TBitBtnLocked
        Left = 380
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F5] Atualizar'
        TabOrder = 3
        OnClick = btnAtualizarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 757
      Top = 2
      Align = alRight
      ExplicitLeft = 757
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 836
    TabOrder = 2
    ExplicitTop = 403
    ExplicitWidth = 836
    inherited pnlNomeForm: TPanel
      Left = 665
      ExplicitLeft = 665
    end
    inherited pnlInfo: TPanel
      Width = 665
      ExplicitWidth = 665
    end
  end
  object pnlCabec: TPanel [2]
    Left = 0
    Top = 0
    Width = 836
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 38
      Width = 142
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade a ser transferida:'
    end
    object Label2: TLabel
      Left = 114
      Top = 15
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object edtQtdIte: TEditFocus
      Left = 157
      Top = 32
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Left = 157
      Top = 9
      Width = 363
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 836
    Height = 286
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'QTDITE'
          Column = cxgItensQTDITE
          DisplayText = 'Total transferido'
          VisibleForCustomization = False
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgItensNUMLOT: TcxGridDBColumn
        Caption = 'Armaz'#233'm'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Width = 119
      end
      object cxgItensAmzDes: TcxGridDBColumn
        Caption = 'Descr. do Armaz'#233'm'
        DataBinding.FieldName = 'AMZDES'
        Options.Editing = False
        Width = 109
      end
      object cxgItensLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Width = 119
      end
      object cxgItensDTAVAL: TcxGridDBColumn
        Caption = 'Data Validade'
        DataBinding.FieldName = 'DTAVAL'
        Options.Editing = False
        Width = 84
      end
      object cxgItensSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensQTDTOT: TcxGridDBColumn
        Caption = '(*) Total transferido'
        DataBinding.FieldName = 'QTDTOT'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 109
      end
      object cxgItensCAPACI: TcxGridDBColumn
        Caption = 'Capacidade'
        DataBinding.FieldName = 'CAPACI'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'A transferir'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxgItensDTAFAB: TcxGridDBColumn
        Caption = 'Data Fabrica'#231#227'o'
        DataBinding.FieldName = 'DTAFAB'
        Options.Editing = False
        Width = 89
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 351
    Width = 836
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    Visible = False
    object chkExiSemSal: TCheckBox
      Left = 7
      Top = 5
      Width = 127
      Height = 17
      Caption = 'Exibir Lotes sem saldo'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkExiSemSalClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 136
  end
  object dtsItens: TDataSource
    Left = 56
    Top = 136
  end
end
