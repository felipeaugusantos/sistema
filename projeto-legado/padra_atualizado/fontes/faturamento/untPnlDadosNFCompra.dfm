object frmPnlDadosNFCompra: TfrmPnlDadosNFCompra
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 2
  Caption = 'frmPnlDadosNFCompra'
  ClientHeight = 46
  ClientWidth = 267
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 267
    Height = 46
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 180
    ExplicitHeight = 33
    object btnItensComprados: TBitBtnLocked
      Left = 11
      Top = 5
      Width = 160
      Height = 23
      Caption = '[F5] Itens comprados'
      TabOrder = 0
      OnClick = btnItensCompradosClick
    end
  end
end
