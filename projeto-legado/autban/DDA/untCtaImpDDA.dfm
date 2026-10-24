inherited frmCtaImpDDA: TfrmCtaImpDDA
  Width = 405
  Height = 269
  BorderStyle = bsNone
  Caption = 'Importa'#231#227'o de Arquivos - DDA'
  ExplicitWidth = 405
  ExplicitHeight = 269
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 227
    Width = 405
    ExplicitTop = 227
    ExplicitWidth = 405
    inherited FlwBotoes: TFlowPanel
      Width = 324
      ExplicitWidth = 401
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
      object btnGravar: TBitBtnLocked
        Tag = 1
        Left = 75
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Importar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 1
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 326
      Top = 2
      Align = alRight
      ExplicitLeft = 322
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 405
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Importa'#231#227'o de Arquivos - DDA'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object pnlPath: TPanel [3]
    Left = 0
    Top = 22
    Width = 405
    Height = 58
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblPathArquivosRet: TLabel
      Left = 10
      Top = 5
      Width = 187
      Height = 14
      Caption = 'Pasta para a Importa'#231#227'o dos Arquivos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCaminhoMsg: TLabel
      Left = 10
      Top = 43
      Width = 121
      Height = 14
      Caption = 'Diret'#243'rio n'#227'o encontrado!'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    inline fraPathImpDDA: TfraDirectoryEditFocus
      Tag = 99
      Left = 9
      Top = 19
      TabOrder = 0
      Width = 389
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      inherited edtDirectory: TEditFocus
        OnChange = fraPathImpDDAedtDirectoryChange
        OnExit = fraPathImpDDAedtDirectoryExit
        OnEnter = fraPathImpDDAedtDirectoryEnter
      end
    end
  end
  object pnlArquivos: TPanel [4]
    Left = 0
    Top = 80
    Width = 405
    Height = 147
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lstArquivo: TFileListBox
      Left = 1
      Top = 1
      Width = 403
      Height = 145
      Align = alClient
      BevelKind = bkSoft
      FileType = [ftReadOnly, ftDirectory, ftNormal]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Mask = '*.txt;*.ret;*.dat;*.rst;*.html'
      MultiSelect = True
      ParentFont = False
      ParentShowHint = False
      ShowGlyphs = True
      ShowHint = False
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 253
    Width = 405
    ExplicitTop = 253
    ExplicitWidth = 405
    inherited pnlNomeForm: TPanel
      Left = 234
      ExplicitLeft = 234
    end
    inherited pnlInfo: TPanel
      Width = 234
      ExplicitWidth = 234
    end
  end
end
