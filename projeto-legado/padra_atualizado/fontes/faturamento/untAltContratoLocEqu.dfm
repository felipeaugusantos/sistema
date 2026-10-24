inherited frmAltContratoLocEqu: TfrmAltContratoLocEqu
  Width = 387
  Height = 136
  Caption = 'Altera'#231#227'o de informa'#231#227'o de contrato'
  ExplicitWidth = 387
  ExplicitHeight = 136
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 65
    Width = 381
    TabOrder = 1
    ExplicitTop = 68
    ExplicitWidth = 392
    inherited FlwBotoes: TFlowPanel
      Width = 377
      ExplicitWidth = 388
    end
    inherited btnSair: TBitBtnLocked
      Left = 298
      ExplicitLeft = 309
    end
  end
  inherited pnlStatus: TPanel
    Top = 91
    Width = 381
    TabOrder = 2
    ExplicitTop = 94
    ExplicitWidth = 392
    inherited pnlNomeForm: TPanel
      Left = 210
      ExplicitLeft = 221
    end
    inherited pnlInfo: TPanel
      Width = 210
      ExplicitWidth = 221
    end
  end
  object grbDuracao: TGroupBox [2]
    Left = 8
    Top = 8
    Width = 355
    Height = 42
    Caption = '   Dura'#231#227'o do Contrato   '
    TabOrder = 0
    TabStop = True
    object lblInicio: TLabel
      Left = 14
      Top = 18
      Width = 27
      Height = 14
      Caption = 'In'#237'cio:'
    end
    object lblTermino: TLabel
      Left = 187
      Top = 18
      Width = 41
      Height = 14
      Caption = 'T'#233'rmino:'
    end
    object edtDtaIni: TDBEditFocus
      Tag = 99
      Left = 58
      Top = 15
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_DTAINI'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtHorIni: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 15
      Width = 57
      Height = 22
      Color = 16768952
      DataField = 'EQL_HORINI'
      Enabled = False
      MaxLength = 5
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtHorFin: TMaskEditFocus
      Tag = 99
      Left = 300
      Top = 14
      Width = 35
      Height = 22
      EditMask = '99:99;1;_'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
      OnKeyDown = edtHorFinKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDtaFin: TMaskEditFocus
      Tag = 99
      Left = 234
      Top = 14
      Width = 64
      Height = 22
      BiDiMode = bdLeftToRight
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
end
