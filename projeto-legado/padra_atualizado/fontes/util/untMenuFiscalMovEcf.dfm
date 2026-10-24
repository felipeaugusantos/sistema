inherited frmMenuFiscalMovEcf: TfrmMenuFiscalMovEcf
  Width = 513
  Height = 290
  Caption = 'Movimento por ECF'
  ExplicitWidth = 513
  ExplicitHeight = 290
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 246
    Width = 507
    Height = 0
    Visible = False
    ExplicitTop = 246
    ExplicitWidth = 507
    ExplicitHeight = 0
    DesignSize = (
      507
      0)
    inherited btnSair: TBitBtnLocked
      Left = 424
      Top = -25
      ExplicitLeft = 424
      ExplicitTop = -25
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 41
    Width = 507
    Height = 205
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 96
      Width = 26
      Height = 14
      Caption = 'Geral'
    end
    object lblDetalhe: TLabel
      Left = 16
      Top = 136
      Width = 36
      Height = 14
      Caption = 'Detalhe'
    end
    object Label2: TLabel
      Left = 376
      Top = 24
      Width = 98
      Height = 14
      Caption = 'C'#243'digo nacional ECF'
    end
    object rdgIntervalo: TRadioGroup
      Tag = 99
      Left = 8
      Top = 8
      Width = 193
      Height = 73
      Caption = 'Intervalo'
      ItemIndex = 0
      Items.Strings = (
        'Per'#237'odo')
      TabOrder = 0
      OnClick = rdgIntervaloClick
    end
    object gpbValores: TGroupBox
      Tag = 99
      Left = 204
      Top = 8
      Width = 165
      Height = 73
      Caption = 'Valores da Sele'#231#227'o'
      TabOrder = 1
      object lblFiltroIni: TLabel
        Left = 9
        Top = 24
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
      end
      object lblFiltroFin: TLabel
        Left = 85
        Top = 24
        Width = 47
        Height = 14
        Caption = 'Data Final'
      end
      object mskFiltroIni: TMaskEditFocus
        Tag = 99
        Left = 6
        Top = 40
        Width = 69
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskFiltroFin: TMaskEditFocus
        Tag = 99
        Left = 85
        Top = 40
        Width = 71
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object pgbGeral: TProgressBar
      Left = 16
      Top = 112
      Width = 473
      Height = 16
      Smooth = True
      TabOrder = 3
    end
    object pgbDetalhe: TProgressBar
      Left = 16
      Top = 152
      Width = 473
      Height = 16
      Smooth = True
      TabOrder = 4
    end
    object btnExportar: TBitBtnLocked
      Left = 16
      Top = 174
      Width = 114
      Height = 22
      Caption = '&Exportar'
      TabOrder = 5
      OnClick = btnExportarClick
    end
    object edtCodNac: TEditFocus
      Left = 375
      Top = 39
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 507
    Height = 41
    Align = alTop
    Caption = 'Movimento por ECF'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited pnlStatus: TPanel
    Top = 246
    Width = 507
    ExplicitTop = 246
    ExplicitWidth = 507
    inherited pnlNomeForm: TPanel
      Left = 336
      ExplicitLeft = 336
    end
    inherited pnlInfo: TPanel
      Width = 336
      ExplicitWidth = 336
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
  object tmrIniciarExportacao: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrIniciarExportacaoTimer
    Left = 384
    Top = 121
  end
end
