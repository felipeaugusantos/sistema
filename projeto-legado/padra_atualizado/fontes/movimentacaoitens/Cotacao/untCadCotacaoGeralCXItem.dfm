inherited frmCadCotacaoGeralCXItem: TfrmCadCotacaoGeralCXItem
  Width = 630
  Height = 247
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Complete as informa'#231#245'es do item'
  Position = poMainFormCenter
  ExplicitWidth = 630
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 174
    Width = 624
    Visible = False
    ExplicitTop = 104
    ExplicitWidth = 815
    inherited FlwBotoes: TFlowPanel
      Width = 620
      ExplicitTop = 2
      ExplicitWidth = 811
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 541
      ExplicitLeft = 732
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 624
    ExplicitTop = 132
    ExplicitWidth = 815
    inherited pnlNomeForm: TPanel
      Left = 453
      ExplicitLeft = 644
    end
    inherited pnlInfo: TPanel
      Width = 453
      Alignment = taLeftJustify
      ExplicitWidth = 644
    end
  end
  object pnlEmpresa: TPanel [3]
    Left = 0
    Top = 114
    Width = 624
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 98
    ExplicitWidth = 815
    object Label1: TLabel
      Left = 10
      Top = 12
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emp:'
    end
    object edtCodEmp: TEditFocus
      Left = 34
      Top = 4
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnExcluir: TBitBtnLocked
      Left = 10
      Top = 38
      Width = 72
      Height = 22
      Caption = '&Excluir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      Visible = False
      OnClick = btnExcluirClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 664
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 576
    Top = 72
  end
end
