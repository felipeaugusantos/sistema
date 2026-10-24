inherited frmFatDigTipoEntregaItens: TfrmFatDigTipoEntregaItens
  Width = 1024
  Height = 145
  Caption = 'Altera'#231#227'o de Entrega / Retira dos Produtos da Venda'
  ExplicitWidth = 1024
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 1018
    TabOrder = 1
    ExplicitTop = 74
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 100
    Width = 1018
    TabOrder = 2
    ExplicitTop = 100
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
  object pnlMotivo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 74
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lblMotEntFut: TLabel
      Left = 330
      Top = 16
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
    end
    object lblDatEnt: TLabel
      Left = 567
      Top = 16
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Ent:'
    end
    object lblEntRet: TLabel
      Left = 3
      Top = 16
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Destino:'
    end
    object lblCliBus: TLabel
      Left = 680
      Top = 16
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente vai retirar?'
      Visible = False
    end
    object lblTurno: TLabel
      Left = 818
      Top = 16
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Turno:'
      Visible = False
    end
    object lblDiaEnt: TLabel
      Left = 489
      Top = 15
      Width = 45
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Dias Ent.:'
    end
    object cmbMotEntFut: TComboBoxFocus
      Tag = 99
      Left = 366
      Top = 9
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnChange = cmbMotEntFutChange
      Items.Strings = (
        'Falta Produto'
        'Aguardando Cliente'
        'Previs'#227'o de Entrega')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 613
      Top = 9
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      OnChange = mskDtaEntChange
      OnExit = mskDtaEntExit
      OnKeyPress = mskDtaEntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cmbEntRet: TComboBoxFocus
      Tag = 99
      Left = 44
      Top = 9
      Width = 79
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 1
      ParentFont = False
      TabOrder = 0
      Text = 'RETIRA'
      OnChange = cmbEntRetChange
      Items.Strings = (
        'ENTREGA'
        'RETIRA')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbCliBus: TComboBoxFocus
      Tag = 99
      Left = 768
      Top = 9
      Width = 47
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      Visible = False
      Items.Strings = (
        'N'#195'O'
        'SIM')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbTurEnt: TComboBoxFocus
      Tag = 99
      Left = 850
      Top = 9
      Width = 57
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      Visible = False
      Items.Strings = (
        'Manh'#227
        'Tarde'
        'Noite')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtDiaEnt: TEditFocus
      Tag = 99
      Left = 535
      Top = 9
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtDiaEntExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object pnlTipEnt: TPanel
      Left = 124
      Top = 7
      Width = 200
      Height = 27
      BevelOuter = bvNone
      TabOrder = 1
      object lblTipEnt: TLabel
        Left = 2
        Top = 8
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Entrega:'
        Visible = False
      end
      object cmbTipEnt: TComboBoxFocus
        Tag = 99
        Left = 65
        Top = 2
        Width = 128
        Height = 22
        Style = csDropDownList
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 1
        ParentFont = False
        TabOrder = 0
        Text = 'IMEDIATA'
        Visible = False
        OnChange = cmbTipEntChange
        Items.Strings = (
          'FUTURA'
          'IMEDIATA')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlLocRet: TPanel
      Left = 126
      Top = 7
      Width = 200
      Height = 27
      BevelOuter = bvNone
      TabOrder = 2
      object lblLocRet: TLabel
        Left = 4
        Top = 8
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Local Retira:'
      end
      object cmbLocRet: TComboBoxFocus
        Tag = 99
        Left = 65
        Top = 2
        Width = 133
        Height = 22
        Style = csDropDownList
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        Items.Strings = (
          'CAIXA'
          'EXPEDI'#199#195'O'
          'BALC'#195'O')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object rdgPegou: TRadioGroup
      Left = 919
      Top = 0
      Width = 88
      Height = 65
      Caption = 'J'#225' Pegou?'
      ItemIndex = 0
      Items.Strings = (
        'Manter'
        'Sim'
        'N'#227'o')
      TabOrder = 8
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 256
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 48
  end
end
