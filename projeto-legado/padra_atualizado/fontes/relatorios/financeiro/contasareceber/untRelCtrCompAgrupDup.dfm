inherited frmRelCtrCompAgrupDup: TfrmRelCtrCompAgrupDup
  Left = 304
  Top = 190
  Width = 583
  Height = 547
  BorderStyle = bsDialog
  Caption = 'Relat'#243'rio de Reimpress'#227'o Comprovante Agrupamento de Duplicatas'
  ExplicitWidth = 583
  ExplicitHeight = 547
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 476
    Width = 577
    ExplicitTop = 476
    ExplicitWidth = 577
    object Label2: TLabel [0]
      Left = 176
      Top = 6
      Width = 289
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Pressione Enter para Marcar / Desmarcar '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 496
      ExplicitWidth = 496
    end
    inherited btnSair: TBitBtnLocked
      Left = 498
      ExplicitLeft = 498
    end
  end
  inherited pnlDados: TPanel
    Width = 577
    Height = 476
    ExplicitWidth = 577
    ExplicitHeight = 476
    inherited gpbDestino: TGroupBox
      Top = 480
      TabOrder = 1
      Visible = False
      ExplicitTop = 480
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 575
      Height = 475
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 84
        Top = 79
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label20: TLabel
        Left = 74
        Top = 56
        Width = 45
        Height = 14
        Caption = 'Empresa:'
      end
      object Label3: TLabel
        Left = 51
        Top = 10
        Width = 68
        Height = 14
        Caption = 'Agrupamento:'
      end
      object Label4: TLabel
        Left = 4
        Top = 32
        Width = 115
        Height = 14
        Caption = 'Ordenar impress'#227'o por:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 121
        Top = 75
        Width = 103
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 3
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
        Left = 225
        Top = 75
        Width = 339
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtNomEmp: TEditFocus
        Left = 225
        Top = 52
        Width = 339
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 121
        Top = 52
        Width = 103
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object dbgAgrupamentos: TDBGridCitel
        Left = 2
        Top = 102
        Width = 571
        Height = 371
        Align = alBottom
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 4
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgAgrupamentosDrawColumnCell
        OnDblClick = dbgAgrupamentosDblClick
        OnKeyDown = FormKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'NUMAGR'
            Title.Caption = 'N'#186' Agrup.'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMPAGR'
            Title.Caption = 'Empresa'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODCLI'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Width = 54
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMCLI'
            Title.Caption = 'Cliente'
            Width = 222
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'TOTAGR'
            Title.Alignment = taRightJustify
            Title.Caption = 'Total Duplicatas'
            Width = 107
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MARDES'
            Title.Caption = 'Set'
            Visible = False
          end>
      end
      object edtNumAgr: TEditFocus
        Tag = 99
        Left = 121
        Top = 6
        Width = 103
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object cbxImpAG: TComboBoxFocus
        Left = 121
        Top = 29
        Width = 103
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'N'#250'mero AG'
        Items.Strings = (
          'N'#250'mero AG'
          'Nome do Cliente')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 502
    Width = 577
    ExplicitTop = 502
    ExplicitWidth = 577
    inherited pnlNomeForm: TPanel
      Left = 406
      ExplicitLeft = 406
    end
    inherited pnlInfo: TPanel
      Width = 406
      ExplicitWidth = 406
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 24
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 640
    Top = 24
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 896
    Top = 24
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 864
    Top = 24
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 832
    Top = 24
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 800
    Top = 24
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 768
    Top = 24
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 704
    Top = 24
  end
  inherited frxGen: TfrxUserDataSet
    Left = 736
    Top = 24
  end
  inherited frxDesigner: TfrxDesigner
    Left = 960
    Top = 24
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 992
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 56
  end
end
