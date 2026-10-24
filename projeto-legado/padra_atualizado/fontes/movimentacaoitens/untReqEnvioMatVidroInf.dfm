inherited frmReqEnvioMatVidroInf: TfrmReqEnvioMatVidroInf
  Width = 617
  Height = 526
  Caption = 
    'Requisi'#231#227'o de Envio de Materiais - Vidro - Informa'#231#245'es Fechament' +
    'o'
  ExplicitWidth = 617
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 455
    Width = 611
    TabOrder = 1
    ExplicitTop = 455
    ExplicitWidth = 611
    inherited FlwBotoes: TFlowPanel
      Width = 530
      ExplicitTop = 2
      ExplicitWidth = 530
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 532
      Top = 2
      Align = alRight
      ExplicitLeft = 532
      ExplicitTop = 2
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 611
    Height = 455
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbl2: TLabel
      Left = 60
      Top = 11
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vidro:'
      WordWrap = True
    end
    object Label1: TLabel
      Left = 36
      Top = 113
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ferragens:'
      WordWrap = True
    end
    object Label2: TLabel
      Left = 46
      Top = 217
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Alum'#237'nio:'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 20
      Top = 320
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
      WordWrap = True
    end
    object Label19: TLabel
      Left = 8
      Top = 428
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obra Finalizada?'
    end
    object ColorLabel1: TColorLabel
      Left = 114
      Top = 428
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object memInfVid: TMemoFocus
      Tag = 99
      Left = 92
      Top = 9
      Width = 500
      Height = 95
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object memInfFer: TMemoFocus
      Tag = 99
      Left = 92
      Top = 111
      Width = 500
      Height = 95
      ScrollBars = ssVertical
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object memInfAlu: TMemoFocus
      Tag = 99
      Left = 92
      Top = 215
      Width = 500
      Height = 95
      ScrollBars = ssVertical
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object memObserv: TMemoFocus
      Tag = 99
      Left = 92
      Top = 318
      Width = 500
      Height = 95
      ScrollBars = ssVertical
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtObrFin: TEditFocus
      Tag = 99
      Left = 93
      Top = 423
      Width = 18
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 4
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
  end
  inherited pnlStatus: TPanel
    Top = 481
    Width = 611
    TabOrder = 2
    ExplicitTop = 481
    ExplicitWidth = 611
    inherited pnlNomeForm: TPanel
      Left = 440
      ExplicitLeft = 440
    end
    inherited pnlInfo: TPanel
      Width = 440
      ExplicitWidth = 440
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 432
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 432
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 432
  end
end
