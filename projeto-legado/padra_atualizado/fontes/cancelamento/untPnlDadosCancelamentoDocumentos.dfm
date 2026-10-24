object frmPnlDadosCancelamentoDocumentos: TfrmPnlDadosCancelamentoDocumentos
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 45
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 45
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object btnCancelamentoNaoAutorizado: TBitBtnLocked
      Left = 16
      Top = 10
      Width = 234
      Height = 25
      Caption = '[F10] Cancelamento n'#227'o autorizado'
      TabOrder = 0
      OnClick = btnCancelamentoNaoAutorizadoClick
    end
  end
end
