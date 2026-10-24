inherited frmConsultaCadCtaReceber: TfrmConsultaCadCtaReceber
  Left = 194
  Top = 155
  Caption = 'Consulta - Contas a Receber'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 313
  end
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      Left = 543
      ExplicitLeft = 543
    end
  end
  object pnlAuxiliar: TPanel [4]
    Left = 0
    Top = 313
    Width = 780
    Height = 33
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object btnEnviarEmail: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 153
      Height = 25
      Caption = '[ F9 ] - Duplicatas Agrupadas'
      TabOrder = 0
      OnClick = btnEnviarEmailClick
    end
  end
end
