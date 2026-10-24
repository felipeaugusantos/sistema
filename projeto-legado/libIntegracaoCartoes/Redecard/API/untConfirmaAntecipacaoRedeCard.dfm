inherited frmConfirmaAntecipacaoRedeCard: TfrmConfirmaAntecipacaoRedeCard
  Width = 561
  Height = 432
  BorderIcons = [biSystemMenu]
  Caption = ''
  DefaultMonitor = dmDesktop
  Position = poMainFormCenter
  ExplicitWidth = 561
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 403
    Width = 555
    Height = 0
    Visible = False
    ExplicitTop = 403
    ExplicitWidth = 555
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 551
      ExplicitWidth = 551
    end
    inherited btnSair: TBitBtnLocked
      Left = 153
      Top = -25
      ExplicitLeft = 153
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 555
    Height = 0
    Visible = False
    ExplicitTop = 403
    ExplicitWidth = 555
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 384
      Height = 0
      ExplicitLeft = 384
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 384
      Height = 0
      ExplicitWidth = 384
      ExplicitHeight = 0
    end
    inherited pnlBotoesTrace: TPanel
      Height = 0
      ExplicitHeight = 0
      inherited btnIniciarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
    end
  end
  object pnlRecebaHoje: TPanel [2]
    Left = 0
    Top = 0
    Width = 242
    Height = 403
    Align = alLeft
    ShowCaption = False
    TabOrder = 2
    object pnlTotais: TPanel
      AlignWithMargins = True
      Left = 26
      Top = 356
      Width = 190
      Height = 36
      Margins.Left = 25
      Margins.Top = 20
      Margins.Right = 25
      Margins.Bottom = 10
      Align = alBottom
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      StyleElements = []
      object lblContinuarHoje: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 9
        Width = 184
        Height = 24
        Margins.Top = 9
        Align = alClient
        Alignment = taCenter
        Caption = 'Continuar'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        OnClick = lblContinuarHojeClick
        ExplicitWidth = 70
        ExplicitHeight = 18
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 26
      Width = 220
      Height = 46
      Margins.Left = 10
      Margins.Top = 1
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      StyleElements = []
      object Label4: TLabel
        AlignWithMargins = True
        Left = 20
        Top = 13
        Width = 54
        Height = 30
        Margins.Left = 20
        Margins.Top = 13
        Margins.Right = 0
        Align = alLeft
        Alignment = taCenter
        Caption = 'Receba'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 18
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 111
        Top = 13
        Width = 89
        Height = 30
        Margins.Left = 0
        Margins.Top = 13
        Align = alLeft
        Alignment = taCenter
        Caption = 'na sua conta'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 18
      end
      object lblHoje: TLabel
        AlignWithMargins = True
        Left = 78
        Top = 13
        Width = 31
        Height = 30
        Margins.Left = 4
        Margins.Top = 13
        Margins.Right = 2
        Align = alLeft
        Alignment = taCenter
        Caption = 'hoje'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 18
      end
    end
    object pnlTotalTaxa: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 210
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object Label3: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 54
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Taxa Aplicada:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalTaxa: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label7: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 12
        ExplicitTop = 25
        ExplicitWidth = 218
      end
    end
    object pnlTotalAntecipacao: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 82
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 3
      object Label22: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 69
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Total Antecipado:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalAntecipado: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label24: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 12
        ExplicitTop = 27
        ExplicitWidth = 208
      end
    end
    object pnlTotalDesconto: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 146
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 4
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 59
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Total Desconto:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalDesconto: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label25: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 1
        ExplicitTop = 18
        ExplicitWidth = 208
      end
    end
    object pnlTotalLiquido: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 284
      Width = 220
      Height = 55
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 5
      object Label8: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 214
        Height = 12
        Align = alTop
        AutoSize = False
        Caption = 'Total na sua conta'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 4
        ExplicitWidth = 212
      end
      object lblTotalLiquido: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 21
        Width = 214
        Height = 22
        Align = alTop
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 68
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 87
      Height = 14
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 143
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      ShowCaption = False
      TabOrder = 6
      StyleElements = []
      object lblPrazoHoje: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 1
        Width = 87
        Height = 11
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = ' Hoje at'#233' as 14H20'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentFont = False
        StyleElements = []
        ExplicitWidth = 83
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 313
    Top = 0
    Width = 242
    Height = 403
    Align = alRight
    ShowCaption = False
    TabOrder = 3
    object lblContinuarUtil: TPanel
      AlignWithMargins = True
      Left = 26
      Top = 356
      Width = 190
      Height = 36
      Margins.Left = 25
      Margins.Top = 20
      Margins.Right = 25
      Margins.Bottom = 10
      Align = alBottom
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      StyleElements = []
      OnClick = lblContinuarUtilClick
      object Label20: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 9
        Width = 184
        Height = 24
        Margins.Top = 9
        Align = alClient
        Alignment = taCenter
        Caption = 'Continuar'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        OnClick = lblContinuarUtilClick
        ExplicitWidth = 70
        ExplicitHeight = 18
      end
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 25
      Width = 220
      Height = 46
      Margins.Left = 10
      Margins.Top = 24
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      StyleElements = []
      object Label14: TLabel
        AlignWithMargins = True
        Left = 98
        Top = 13
        Width = 108
        Height = 30
        Margins.Left = 4
        Margins.Top = 13
        Margins.Right = 2
        Align = alLeft
        Alignment = taCenter
        Caption = 'pr'#243'ximo dia '#250'til'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 18
      end
      object Label19: TLabel
        AlignWithMargins = True
        Left = 18
        Top = 13
        Width = 76
        Height = 30
        Margins.Left = 18
        Margins.Top = 13
        Margins.Right = 0
        Align = alLeft
        Alignment = taCenter
        Caption = 'Receba no'
        Color = clGrayText
        Font.Charset = ARABIC_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 18
      end
    end
    object pnlTotalAntecipacaoUtil: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 81
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 69
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Total Antecipado:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalAntecipadoUtil: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label26: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 12
        ExplicitWidth = 208
      end
    end
    object pnlTotalLiquidoUtil: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 283
      Width = 220
      Height = 55
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 3
      object Label18: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 214
        Height = 12
        Align = alTop
        AutoSize = False
        Caption = 'Total na sua conta'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 12
        ExplicitTop = 28
        ExplicitWidth = 208
      end
      object lblTotalLiquidoUtil: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 21
        Width = 214
        Height = 22
        Align = alTop
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 68
      end
    end
    object pnlTotalDescontoUtil: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 145
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 4
      object Label6: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 59
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Total Desconto:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalDescontoUtil: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label28: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 4
        ExplicitWidth = 208
      end
    end
    object pnlTotalTaxaUtil: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 209
      Width = 220
      Height = 64
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 5
      object Label5: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 54
        Height = 34
        Margins.Top = 13
        Align = alLeft
        Caption = 'Taxa Aplicada:'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 32
      end
      object lblTotalTaxaUtil: TLabel
        AlignWithMargins = True
        Left = 172
        Top = 30
        Width = 45
        Height = 17
        Margins.Top = 30
        Align = alRight
        Caption = 'R$ 0,00'
        Color = clGrayText
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentColor = False
        ParentFont = False
        ExplicitHeight = 16
      end
      object Label9: TLabel
        Left = 0
        Top = 50
        Width = 220
        Height = 14
        Align = alBottom
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '_____'
        ExplicitLeft = 4
        ExplicitWidth = 208
      end
    end
  end
  object Panel5: TPanel [4]
    Left = 242
    Top = 0
    Width = 71
    Height = 403
    Align = alClient
    ShowCaption = False
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 384
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 384
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 384
  end
end
