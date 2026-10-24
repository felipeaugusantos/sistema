inherited frmExclusaoAutCtaPagar: TfrmExclusaoAutCtaPagar
  Left = 163
  Top = 141
  Width = 1024
  Height = 650
  Caption = 'Exclus'#227'o de Contas a Pagar'
  Position = poMainFormCenter
  OnPaint = nil
  ExplicitWidth = 1024
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 209
    Top = 123
    Width = 6
    Height = 14
    Alignment = taRightJustify
    Caption = #224
  end
  inherited pnlBotoes: TPanel
    Top = 580
    Width = 1018
    TabOrder = 4
    ExplicitTop = 580
    ExplicitWidth = 1018
    DesignSize = (
      1018
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 605
    Width = 1018
    ExplicitTop = 605
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 864
      Width = 154
      ExplicitLeft = 864
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 864
      ExplicitWidth = 864
      object shpMultSel: TShape
        Left = 848
        Top = 2
        Width = 14
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 843
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 580
    Visible = False
    ExplicitWidth = 1018
    ExplicitHeight = 580
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 548
    end
  end
  object pnlAux1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 580
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object pnlTotais: TPanel
      Left = 0
      Top = 404
      Width = 1018
      Height = 176
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label21: TLabel
        Left = 275
        Top = 9
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label6: TLabel
        Left = 17
        Top = 9
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Duplicatas:'
      end
      object Label9: TLabel
        Left = 2
        Top = 32
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Selecionadas:'
      end
      object Label7: TLabel
        Left = 42
        Top = 55
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pl. Contas:'
      end
      object Label10: TLabel
        Left = 41
        Top = 78
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label12: TLabel
        Left = 24
        Top = 101
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dta. Cadastro:'
      end
      object Label14: TLabel
        Left = 394
        Top = 78
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label4: TLabel
        Left = 42
        Top = 124
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o?:'
      end
      object Label8: TLabel
        Left = 411
        Top = 55
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'S'#233'rie:'
      end
      object Label13: TLabel
        Left = 404
        Top = 9
        Width = 36
        Height = 14
        Caption = 'Evento:'
      end
      object Label15: TLabel
        Left = 388
        Top = 32
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label5: TLabel
        Left = 135
        Top = 9
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Des.:'
      end
      object Label18: TLabel
        Left = 140
        Top = 32
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Jur.:'
      end
      object Label20: TLabel
        Left = 45
        Top = 147
        Width = 47
        Height = 14
        Caption = 'Doc. Ant.:'
      end
      object lblTotVendor: TLabel
        Left = 258
        Top = 32
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Ven:'
      end
      object lblMulta: TLabel
        Left = 260
        Top = 55
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Mul.:'
      end
      object edtQtdDuplicatas: TEditFocus
        Left = 96
        Top = 5
        Width = 36
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdSelecionadas: TEditFocus
        Left = 96
        Top = 28
        Width = 36
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValorTotal: TEditFocus
        Left = 301
        Top = 5
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCtaBai: TEditFocus
        Left = 96
        Top = 51
        Width = 154
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesCtaBai: TEditFocus
        Left = 96
        Top = 74
        Width = 276
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDtaCad: TEditFocus
        Left = 96
        Top = 97
        Width = 276
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPreVis: TEditFocus
        Left = 96
        Top = 120
        Width = 276
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSerie: TEditFocus
        Left = 442
        Top = 51
        Width = 220
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEveBai: TEditFocus
        Left = 442
        Top = 5
        Width = 220
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesEveBai: TEditFocus
        Left = 442
        Top = 28
        Width = 220
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotDesconto: TEditFocus
        Left = 181
        Top = 5
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtTotJuros: TEditFocus
        Left = 181
        Top = 28
        Width = 69
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVel: TEditFocus
        Left = 96
        Top = 143
        Width = 276
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotVendor: TEditFocus
        Left = 301
        Top = 28
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtHistor: TMemoFocus
        Left = 442
        Top = 74
        Width = 220
        Height = 91
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 14
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object edtOutEnt: TEditFocus
        Left = 668
        Top = 116
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 15
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotMulta: TEditFocus
        Left = 301
        Top = 51
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object dbgDuplicatas: TcxGrid
      Left = 0
      Top = 0
      Width = 1018
      Height = 404
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasView: TcxGridDBTableView
        OnDblClick = dbgDuplicatasViewDblClick
        OnKeyDown = dbgDuplicatasViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDuplicatasViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        object dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'CTP_NUMDUP'
          Width = 88
        end
        object dbgDuplicatasCTP_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTP_CODEMP'
          Width = 31
        end
        object dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn
          Caption = 'Nom. Forn.'
          DataBinding.FieldName = 'CTP_NOMFOR'
          Width = 155
        end
        object dbgDuplicatasCTP_CODPOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'CTP_NOMPOR'
          Width = 153
        end
        object dbgDuplicatasCTP_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'CTP_DTACAD'
          Width = 65
        end
        object dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTP_DTAVEN'
          Width = 70
        end
        object dbgDuplicatasCTP_USACHQ: TcxGridDBColumn
          Caption = 'Cheque?'
          DataBinding.FieldName = 'CTP_USACHQ'
          Width = 53
        end
        object dbgDuplicatasCTP_VEIOBO: TcxGridDBColumn
          Caption = 'Veio Boleto?'
          DataBinding.FieldName = 'CTP_VEIOBO'
          Width = 66
        end
        object dbgDuplicatasCTP_VEIONF: TcxGridDBColumn
          Caption = 'Veio NF?'
          DataBinding.FieldName = 'CTP_VEIONF'
          Width = 66
        end
        object dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn
          Caption = 'Desconto'
          DataBinding.FieldName = 'CTP_DESSUJ'
          Width = 58
        end
        object dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn
          Caption = 'Juros'
          DataBinding.FieldName = 'CTP_JURSUJ'
          Width = 55
        end
        object dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn
          Caption = 'Multa'
          DataBinding.FieldName = 'CTP_MULSUJ'
          Width = 55
        end
        object dbgDuplicatasTOTDUP: TcxGridDBColumn
          Caption = 'Valor Corrigido'
          DataBinding.FieldName = 'TOTDUP'
          Width = 78
        end
        object dbgDuplicatasCTP_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTP_MARDES'
          Visible = False
        end
        object dbgDuplicatasCTP_SERIE_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGRSER'
          Visible = False
        end
        object dbgDuplicatasCTP_NUMDUP_AG: TcxGridDBColumn
          DataBinding.FieldName = 'NRODUP'
          Visible = False
        end
        object dbgDuplicatasCTP_CODEMP_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGREMP'
          Visible = False
        end
        object dbgDuplicatasCTP_CODFOR_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGRFOR'
          Visible = False
        end
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasView
      end
    end
  end
  object pnlBotoesBaixa: TPanel [5]
    Left = 0
    Top = 580
    Width = 1018
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 846
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnMarcarTodas: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 138
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 0
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 138
        Top = 0
        Width = 138
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 1
        OnClick = btnDesmarcarTodasClick
      end
      object BtnSelecionadas: TBitBtnLocked
        Left = 276
        Top = 0
        Width = 138
        Height = 21
        Caption = '[ F9 ] Selecionadas'
        TabOrder = 2
        OnClick = BtnSelecionadasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 414
        Top = 0
        Width = 138
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 3
        OnClick = btnConfirmaClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 872
      Top = 2
      Width = 144
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
    object btnHlpImp: TcxButton
      Left = 848
      Top = 2
      Width = 24
      Height = 21
      Align = alRight
      LookAndFeel.SkinName = 'Blue'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000001000000080000001000000010000000080000
        0001000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000006301D125F8A4C2DED854526ED28140B600000
        0007000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000D9F6A49EAD8A471FFD3985FFF834527EA0000
        000E000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D5030EC0000
        000D000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000532271F50A28368D29E7D61D22F231A510000
        0005000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000010000000600000011000000140000000A0000
        0002000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000670503AA999532EFF4528187A0000
        0007000000010000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000079F795AD7E5BF92FFAF724AF72415
        0D49000000080000000200000000000000000000000000000000000000000000
        00000000000100000004000000060000000868534089D6AD86FFF1D09FFFB477
        4BFF693D24AE0D08052000000002000000000000000000000000000000000000
        0000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2AAFFF6D3
        9CFFD8A470FF75452ABD00000006000000000000000000000000000000000000
        000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B76FFF8E7
        BCFFF3CC95FFA0623BF700000007000000000000000000000000000000000000
        0000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C19770FFF9EC
        C4FFE8CCA4FF845435C700000005000000000000000000000000000000000000
        0000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1C5FFDDBF
        9EFFAF7D58F01F140D3400000001000000000000000000000000000000000000
        00000000000000000001231E182D877158A5C3A07DEED9BA96FFBA9977E57053
        3B9A17100A250000000200000000000000000000000000000000000000000000
        0000000000000000000000000001000000010000000200000003000000020000
        00020000000100000000000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = btnHlpImpExit
      OnMouseLeave = btnHlpImpMouseLeave
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      OnClick = btnHlpImpClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 984
    Top = 28
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 948
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 768
    Top = 80
  end
  object frxReciboM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42997.707318553200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 17 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 716
    Top = 52
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object rllNomEmp: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 34.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE DOCUMENTOS BAIXADOS')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#18#27#80#15#27#77'
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllNomCli: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
        object rllCodCli: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FONE / FAX:')
          TruncOutboundText = False
        end
        object rllFone01: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NUM. DOC.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. VCTO.')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          TruncOutboundText = False
        end
        object rllFax: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1459.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. PGTO.')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          TruncOutboundText = False
        end
        object rllHist01: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1526.400000000000000000
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object rllAssinatura: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
          TruncOutboundText = False
        end
        object rllRiscoAssinatura: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '_______________________________________________')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1027.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllTotValDup: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object rllTotValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 238.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CUmCheque
        PrintChildIfInvisible = True
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReciboM.Page1
        end
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 255.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CVariosCheques
        PrintChildIfInvisible = True
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 68.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 393.699745735580900000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1488.000000000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 85.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReciboJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42997.640509224540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 70 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 776
    Top = 48
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 103.866110000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object Shape1: TfrxShapeView
          Align = baBottom
          Left = 3.000000000000000000
          Top = 86.858235980000000000
          Width = 1096.063700000000000000
          Height = 17.007874020000000000
          Fill.BackColor = clSilver
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 185.046105000000000000
          Top = 5.661410000000000000
          Width = 725.971490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 817.889610000000000000
          Top = 5.661410000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA')
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 171.817750000000000000
          Top = 27.661410000000000000
          Width = 752.428200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE DOCUMENTOS BAIXADOS')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 758.248670000000000000
          Top = 27.661410000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
        end
        object Memo5: TfrxMemoView
          Left = 8.600000000000000000
          Top = 44.661409999999990000
          Width = 103.256710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNomCli: TfrxMemoView
          Left = 203.565430000000000000
          Top = 44.661409999999990000
          Width = 350.891280000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 193.662770000000000000
          Top = 44.661409999999990000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCodCli: TfrxMemoView
          Left = 118.374520000000000000
          Top = 44.661409999999990000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 8.600000000000000000
          Top = 61.661410000000000000
          Width = 82.922820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FONE / FAX:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFone01: TfrxMemoView
          Left = 93.563760000000000000
          Top = 61.661410000000000000
          Width = 104.466110000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 5.820470000000000000
          Top = 86.929116769999990000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M.DOC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 108.333890000000000000
          Top = 86.929116769999990000
          Width = 84.359060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 529.025170000000000000
          Top = 86.929116769999990000
          Width = 92.522820000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. VCTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 724.166941340000000000
          Top = 86.929116769999990000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 1001.952785200000000000
          Top = 86.929116769999990000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFax: TfrxMemoView
          Left = 211.711750000000000000
          Top = 61.661410000000000000
          Width = 100.686580000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 200.070810000000000000
          Top = 61.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 965.669140000000000000
          Top = 27.661410000000000000
          Width = 57.902350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
        end
        object TotalPages: TfrxMemoView
          Left = 1005.330550000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
        end
        object Memo4: TfrxMemoView
          Left = 994.171490000000000000
          Top = 5.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
        end
        object Page: TfrxMemoView
          Left = 972.971490000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
        object Memo1: TfrxMemoView
          Left = 626.567410000000000000
          Top = 86.929190000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. PGTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 820.378480000000000000
          Top = 86.929116769999990000
          Width = 86.551178660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 907.307670000000000000
          Top = 86.929190000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 230.551330000000000000
        Width = 1096.063700000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxMemoView
          Left = 5.820470000000000000
          Width = 99.779530000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllHist01: TfrxMemoView
          Left = 106.554360000000000000
          Width = 419.754360000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaVen: TfrxMemoView
          Left = 529.025170000000000000
          Width = 92.522820000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValDup: TfrxMemoView
          Left = 724.015770000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValRec: TfrxMemoView
          Left = 1001.952785200000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 626.567410000000000000
          Width = 92.598425200000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 820.378477560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 911.087197560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 476.220780000000000000
        Width = 1096.063700000000000000
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllAssinatura: TfrxMemoView
          Left = 288.000000000000000000
          Top = 47.000000000000000000
          Width = 94.261410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
        end
        object rllRiscoAssinatura: TfrxMemoView
          Left = 384.302350000000000000
          Top = 47.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '_______________________________________________')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 4.800000000000000000
          Top = 8.000000000000000000
          Width = 712.138900000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValDup: TfrxMemoView
          Left = 716.607881340000000000
          Top = 8.000000000000000000
          Width = 97.889768660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValRec: TfrxMemoView
          Left = 994.393725200000000000
          Top = 8.000000000000000000
          Width = 97.889768660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 812.819420000000000000
          Top = 8.000000000000000000
          Width = 94.110238660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 907.307670000000000000
          Top = 8.000000000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 4.800000000000000000
          Top = 7.559059999999988000
          Width = 1088.504640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 1.944960000000000000
        Top = 275.905690000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CUmCheque
        PrintChildIfInvisible = True
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 1096.063700000000000000
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 302.362400000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CVariosCheques
        PrintChildIfInvisible = True
        object rllBanco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.747990000000020000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object rllAgencia: TfrxMemoView
          Left = 339.740260000000000000
          Top = 22.747990000000020000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object rllConta: TfrxMemoView
          Left = 535.850650000000000000
          Top = 22.747990000000020000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object rllFavorecido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.425169999999980000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object rllBomPara: TfrxMemoView
          Left = 535.889920000000000000
          Top = 45.425169999999980000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object rllCodBco: TfrxMemoView
          Left = 53.692950000000000000
          Top = 22.747990000000020000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object rllNumAge: TfrxMemoView
          Left = 400.992270000000000000
          Top = 22.747990000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
        end
        object rllConCor: TfrxMemoView
          Left = 584.764070000000000000
          Top = 22.747990000000020000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
        end
        object rllFacore: TfrxMemoView
          Left = 83.929190000000000000
          Top = 45.425169999999980000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
        end
        object rllDtaBom: TfrxMemoView
          Left = 609.480520000000000000
          Top = 45.425169999999980000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
        end
        object rllCheque: TfrxMemoView
          Left = 786.299630000000000000
          Top = 22.747990000000020000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object rllNumChq: TfrxMemoView
          Left = 842.992580000000000000
          Top = 22.747990000000020000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.291279999999972000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 786.299630000000000000
          Top = 45.425169999999980000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 844.110700000000000000
          Top = 45.425169999999980000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
        end
        object rllDadChq: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.291279999999972000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1096.063700000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReciboJ.Page1
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 339.740260000000000000
          Top = 24.236240000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 535.850650000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 46.913420000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 535.889920000000000000
          Top = 46.913420000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 53.692950000000000000
          Top = 24.236240000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 400.992270000000000000
          Top = 24.236240000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 584.764070000000000000
          Top = 24.236240000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 83.929190000000000000
          Top = 46.913420000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 609.480520000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 786.299630000000000000
          Top = 24.236240000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 842.992580000000000000
          Top = 24.236240000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 786.299630000000000000
          Top = 46.913420000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 844.110700000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 943.662030000000000000
          Top = 46.354360000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 987.236860000000000000
          Top = 46.354360000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.000000000000000000
          Top = 71.811070000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 816
    Top = 52
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Left = 904
    Top = 60
  end
  object frxDatasetChqEmi: TfrxDBDataset
    UserName = 'frxDatasetChqEmi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 856
    Top = 64
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 488
    Top = 140
  end
end
