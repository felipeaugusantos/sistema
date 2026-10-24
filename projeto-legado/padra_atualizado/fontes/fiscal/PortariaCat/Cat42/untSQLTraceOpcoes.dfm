object frmSQLTraceOpcoes: TfrmSQLTraceOpcoes
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'SQL Trace - Op'#231#245'es'
  ClientHeight = 116
  ClientWidth = 442
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 442
    Height = 116
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object ckCabecalho: TCheckBox
      Left = 18
      Top = 45
      Width = 173
      Height = 17
      Caption = 'Exibir Cabe'#231'alho (Data / Hora)'
      TabOrder = 3
    end
    object rbSimples: TRadioButton
      Left = 18
      Top = 8
      Width = 127
      Height = 31
      Caption = 'Simples'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object rbCompleto: TRadioButton
      Left = 151
      Top = 8
      Width = 127
      Height = 31
      Caption = 'Completo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object rbPerformance: TRadioButton
      Left = 284
      Top = 8
      Width = 157
      Height = 31
      Caption = 'Performance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ckCallStack: TCheckBox
      Left = 197
      Top = 45
      Width = 173
      Height = 17
      Caption = 'Exibir Call Stack'
      TabOrder = 4
    end
    object btnConfirma: TBitBtnLocked
      Left = 18
      Top = 68
      Width = 403
      Height = 38
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 5
    end
  end
end
