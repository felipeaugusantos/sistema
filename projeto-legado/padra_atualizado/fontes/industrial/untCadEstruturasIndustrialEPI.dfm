inherited frmCadEstruturasIndustrialEPI: TfrmCadEstruturasIndustrialEPI
  Width = 658
  Height = 614
  Caption = 'Cadastro de F'#243'rmulas - EPI'#39's'
  OnDestroy = FormDestroy
  ExplicitWidth = 658
  ExplicitHeight = 614
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 542
    Width = 652
    ExplicitTop = 542
    ExplicitWidth = 652
    inherited btnSair: TBitBtnLocked
      Left = 573
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 573
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Height = 24
      Align = alLeft
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 570
    Width = 652
    ExplicitTop = 570
    ExplicitWidth = 652
    inherited pnlNomeForm: TPanel
      Left = 481
      ExplicitLeft = 481
    end
    inherited pnlInfo: TPanel
      Width = 481
      ExplicitWidth = 481
    end
  end
  object dbcDados: TDBCtrlGrid [3]
    Left = 0
    Top = 0
    Width = 652
    Height = 542
    Align = alClient
    PanelHeight = 135
    PanelWidth = 635
    TabOrder = 3
    RowCount = 4
    object DBText1: TDBText
      Left = 11
      Top = 6
      Width = 593
      Height = 17
      DataField = 'EPI_DESCRI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblObs: TLabel
      Left = 127
      Top = 70
      Width = 63
      Height = 14
      Caption = 'Observa'#231#227'o:'
    end
    object Label1: TLabel
      Left = 127
      Top = 27
      Width = 22
      Height = 14
      Caption = 'Uso:'
    end
    object DBImage1: TDBImage
      Left = 11
      Top = 27
      Width = 110
      Height = 94
      DataField = 'EPI_IMGEPI'
      Stretch = True
      TabOrder = 2
      TabStop = False
    end
    object DBMemoFocus1: TDBMemoFocus
      Left = 127
      Top = 87
      Width = 495
      Height = 34
      DataField = 'EPI_OBSERV'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object DBComboBoxFocus1: TDBComboBoxFocus
      Left = 127
      Top = 42
      Width = 258
      Height = 22
      Style = csDropDownList
      DataField = 'EPI_TIPUSO'
      Items.Strings = (
        'N'#227'o Utiliza'
        'Obrigat'#243'rio'
        'Obrigat'#243'rio por Atividade Especifica'
        'Desej'#225'vel')
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object dtsCadEpi: TDataSource
    Left = 288
    Top = 176
  end
end
