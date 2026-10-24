inherited frmImportacaoModeloContabil: TfrmImportacaoModeloContabil
  Width = 555
  Height = 196
  Caption = 'Importa'#231#227'o Modelo Cont'#225'bil'
  ExplicitWidth = 555
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 14
  object lblVersao: TLabel [0]
    Left = 8
    Top = 8
    Width = 106
    Height = 14
    Caption = 'Layout do modelo: 1.0'
  end
  object lblTplacoEmpresa: TLabel [1]
    Left = 8
    Top = 30
    Width = 155
    Height = 14
    Caption = 'Tipo de Plano (empresa logada):'
  end
  inherited pnlBotoes: TPanel
    Top = 125
    Width = 549
    ExplicitTop = 125
    ExplicitWidth = 549
    inherited FlwBotoes: TFlowPanel
      Width = 545
      ExplicitWidth = 545
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Importar'
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 469
      ExplicitLeft = 469
    end
  end
  inherited pnlStatus: TPanel
    Top = 151
    Width = 549
    ExplicitTop = 151
    ExplicitWidth = 549
    inherited pnlNomeForm: TPanel
      Left = 378
      ExplicitLeft = 378
    end
    inherited pnlInfo: TPanel
      Width = 378
      ExplicitWidth = 378
    end
  end
  object GroupBox1: TGroupBox [4]
    Left = 8
    Top = 53
    Width = 530
    Height = 67
    Caption = 'Op'#231#245'es de Importa'#231#227'o'
    TabOrder = 2
    object chkConEmp: TCheckBox
      Left = 15
      Top = 43
      Width = 450
      Height = 17
      Caption = 
        'Importar Par'#226'metros Cont'#225'beis apenas para a empresa Atual (CFG_C' +
        'ONEMP)'
      TabOrder = 1
    end
    object chkHistpl: TCheckBox
      Left = 15
      Top = 21
      Width = 434
      Height = 17
      Caption = 
        'Importar Hist'#243'rico Padr'#227'o apenas para o Tipo de Plano de Contas ' +
        'atual (CFG_HISTPL)'
      TabOrder = 0
      OnClick = chkHistplClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 256
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 65528
  end
end
