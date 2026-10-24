inherited frmImagem: TfrmImagem
  Left = 223
  Top = 137
  Width = 800
  Height = 600
  Caption = 'Foto'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 713
      ExplicitLeft = 713
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 497
    Width = 794
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object lbl1: TLabel
      Left = 159
      Top = 8
      Width = 152
      Height = 14
      Caption = 'Alterar tamanho (Zoom In / Out)'
    end
    object lblTamZoom: TLabel
      Left = 319
      Top = 8
      Width = 36
      Height = 14
      Caption = '(100%)'
    end
    object btnTamFig: TSpinButton
      Left = 134
      Top = 3
      Width = 20
      Height = 25
      DownGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000000000000080800000808000008080000080
        8000008080000080800000808000000000000000000000000000008080000080
        8000008080000080800000808000000000000000000000000000000000000000
        0000008080000080800000808000000000000000000000000000000000000000
        0000000000000000000000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      TabOrder = 0
      UpGlyph.Data = {
        0E010000424D0E01000000000000360000002800000009000000060000000100
        200000000000D800000000000000000000000000000000000000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000000000000000000000000000000000000000000000000000000000000080
        8000008080000080800000000000000000000000000000000000000000000080
        8000008080000080800000808000008080000000000000000000000000000080
        8000008080000080800000808000008080000080800000808000000000000080
        8000008080000080800000808000008080000080800000808000008080000080
        800000808000008080000080800000808000}
      OnDownClick = btnTamFigDownClick
      OnUpClick = btnTamFigUpClick
    end
    object chkTamOri: TCheckBox
      Left = 8
      Top = 7
      Width = 113
      Height = 17
      Caption = 'Tamanho original'
      TabOrder = 1
      OnClick = chkTamOriClick
    end
  end
  object pnlImage: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 497
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 0
      Width = 794
      Height = 497
      Align = alClient
      TabOrder = 0
      object imgFoto: TImage
        Left = 0
        Top = 0
        Width = 790
        Height = 493
        Align = alClient
        Proportional = True
        ExplicitWidth = 788
        ExplicitHeight = 495
      end
    end
  end
end
