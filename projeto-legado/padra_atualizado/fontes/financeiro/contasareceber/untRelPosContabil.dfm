inherited frmRelPosContabil: TfrmRelPosContabil
  Left = 286
  Top = 209
  Width = 277
  Height = 170
  ActiveControl = mskDtaFin
  BorderIcons = [biSystemMenu]
  Caption = 'frmRelPosContabil'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 99
    Width = 269
    TabOrder = 1
    inherited btnSair: TBitBtn
      Left = 188
    end
    inherited btnImprimir: TBitBtn
      Left = 4
    end
    inherited btnConfigurar: TBitBtn
      Left = 81
      Width = 83
    end
  end
  inherited pnlStatus: TPanel
    Top = 127
    Width = 269
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 98
    end
    inherited pnlInfo: TPanel
      Width = 98
    end
  end
  inherited pnlDados: TPanel
    Width = 269
    Height = 99
    TabOrder = 0
    object Label6: TLabel [0]
      Left = 14
      Top = 7
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDtaFin: TLabel [1]
      Left = 105
      Top = 28
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 49
      Width = 146
      Height = 43
      TabOrder = 1
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 19
      end
      inherited edtDestino: TEditFocus
        Top = 16
      end
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 21
      Width = 88
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 272
  end
end
