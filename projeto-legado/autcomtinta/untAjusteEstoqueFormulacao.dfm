inherited frmAjusteEstoqueFormulacao: TfrmAjusteEstoqueFormulacao
  Width = 520
  Height = 508
  BorderIcons = [biSystemMenu]
  Caption = 'Formula'#231#227'o de Tinta de M'#225'quina - Ajuste de Estoque'
  Position = poMainFormCenter
  ExplicitWidth = 520
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 426
    Width = 514
    ExplicitTop = 426
    ExplicitWidth = 514
    inherited FlwBotoes: TFlowPanel
      Width = 510
      ExplicitWidth = 510
    end
  end
  inherited pnlStatus: TPanel
    Top = 463
    Width = 514
    ExplicitTop = 463
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 343
      ExplicitLeft = 343
    end
    inherited pnlInfo: TPanel
      Width = 343
      ExplicitWidth = 343
    end
  end
  inherited pgcDados: TPageControl
    Top = -1
    Align = alNone
    Visible = False
    ExplicitTop = -1
    ExplicitHeight = 460
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 514
    Height = 153
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblCliente: TLabel
      Left = 34
      Top = 31
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblVendedor: TLabel
      Left = 19
      Top = 53
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblDigitador: TLabel
      Left = 24
      Top = 76
      Width = 45
      Height = 14
      Caption = 'Digitador:'
    end
    object lblObservação: TLabel
      Left = 6
      Top = 109
      Width = 63
      Height = 14
      Caption = 'Observa'#231#227'o:'
    end
    object edtCliente: TEditFocus
      Left = 72
      Top = 27
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 137
      Top = 27
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVendedor: TEditFocus
      Left = 72
      Top = 50
      Width = 65
      Height = 22
      Alignment = taLeftJustify
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
    object edtNomVen: TEditFocus
      Left = 137
      Top = 50
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDigitador: TEditFocus
      Left = 72
      Top = 73
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      PasswordChar = '*'
      TabOrder = 4
      OnExit = edtDigitadorExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 137
      Top = 73
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObservacao: TMemoFocus
      Left = 72
      Top = 96
      Width = 435
      Height = 44
      Enabled = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 153
    Width = 514
    Height = 272
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object cxgAjuEstFor: TcxGrid
      Left = 0
      Top = 0
      Width = 514
      Height = 272
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgTblsAjuEstFor: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object tblCodigoItem: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'TMP_CODITE'
          Options.Editing = False
          Width = 70
        end
        object tblColorantesBases: TcxGridDBColumn
          Caption = 'Colorante'
          DataBinding.FieldName = 'TMP_FORMUL'
          Options.Editing = False
          Width = 193
        end
        object tblQtdOriginal: TcxGridDBColumn
          Caption = 'Qtd. Original'
          DataBinding.FieldName = 'TMP_QTDFOR'
          Options.Editing = False
          Width = 75
        end
        object tblQtdAlterada: TcxGridDBColumn
          Caption = 'Qtd. Alterada'
          DataBinding.FieldName = 'TMP_QTDDIG'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnValidate = tblQtdAlteradaPropertiesValidate
          Width = 78
        end
        object tblDiferenca: TcxGridDBColumn
          Caption = 'Diferen'#231'a'
          DataBinding.FieldName = 'TMP_DIFQTD'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnValidate = tblDiferencaPropertiesValidate
          Width = 75
        end
      end
      object cxgAjuEstForLevel1: TcxGridLevel
        GridView = cxgTblsAjuEstFor
      end
    end
  end
  object pnlBotoesAjustes: TPanel [5]
    Left = 0
    Top = 439
    Width = 514
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 100
      Height = 20
      Align = alLeft
      Caption = '[F10] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 412
      Top = 2
      Width = 100
      Height = 20
      Align = alRight
      Caption = '[Esc] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object pnlProgress: TPanel [6]
    Left = 0
    Top = 426
    Width = 514
    Height = 13
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 6
    Visible = False
    object pgbItens: TProgressBar
      Left = 2
      Top = 0
      Width = 510
      Height = 11
      Align = alBottom
      Smooth = True
      TabOrder = 0
      Visible = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 65520
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 24
    Top = 65528
  end
end
