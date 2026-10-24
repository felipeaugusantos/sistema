inherited frmConsultaCompCoralNfmBases: TfrmConsultaCompCoralNfmBases
  Caption = 'frmConsultaCompCoralNfmBases'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 332
  end
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 591
      ExplicitLeft = 591
    end
  end
  inherited Panel1: TPanel
    Top = 332
    Height = 144
    ExplicitTop = 332
    ExplicitHeight = 144
    object lblInformacoes: TLabel [7]
      Left = 1
      Top = 130
      Width = 778
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'BASES N'#195'O RELACIONADAS COM UM ITEM DO CADASTRO DE PRODUTOS NAO A' +
        'PARECERAM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 489
    end
  end
end
