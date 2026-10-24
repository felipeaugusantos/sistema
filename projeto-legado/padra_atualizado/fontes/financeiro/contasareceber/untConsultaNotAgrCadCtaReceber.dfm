inherited frmConsultaNotAgrCadCtaReceber: TfrmConsultaNotAgrCadCtaReceber
  Left = 174
  Top = 197
  Caption = 'Consulta - Contas a Receber (Duplicatas Agrupadas)'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 315
  end
  inherited Panel1: TPanel
    Top = 348
    Height = 128
    ExplicitTop = 348
    ExplicitHeight = 128
  end
  object pnlAuxiliar: TPanel [4]
    Left = 0
    Top = 315
    Width = 780
    Height = 33
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object btnDuplicatas: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 153
      Height = 25
      Caption = '[ F9 ] - Duplicatas'
      TabOrder = 0
      OnClick = btnDuplicatasClick
    end
  end
end
