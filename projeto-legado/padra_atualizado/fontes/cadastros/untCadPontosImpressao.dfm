inherited frmCadPontosImpressao: TfrmCadPontosImpressao
  Width = 723
  Height = 407
  Caption = 'Cadastro de Pontos de Impress'#227'o'
  ExplicitWidth = 723
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 332
    Width = 717
    Height = 30
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ExplicitLeft = -8
    ExplicitTop = 303
    ExplicitWidth = 717
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Left = 4
      Top = 4
      Width = 545
      Height = 22
      Align = alLeft
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitWidth = 545
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        Height = 22
        Align = alLeft
        ExplicitWidth = 75
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 636
      Top = 4
      Align = alRight
      ExplicitLeft = 636
      ExplicitTop = 4
    end
  end
  inherited pnlStatus: TPanel
    Top = 362
    Width = 717
    ExplicitTop = 332
    ExplicitWidth = 717
    inherited pnlNomeForm: TPanel
      Left = 370
      ExplicitLeft = 370
    end
    inherited pnlInfo: TPanel
      Width = 370
      ExplicitWidth = 370
    end
  end
  inherited pgcDados: TPageControl
    Width = 717
    Height = 332
    ExplicitWidth = 717
    ExplicitHeight = 332
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 709
      ExplicitHeight = 300
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 717
    Height = 332
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 18
      Top = 13
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 24
      Top = 36
      Width = 30
      Height = 14
      Caption = 'Nome:'
    end
    object dbeCodPon: TDBEditFocus
      Tag = 99
      Left = 56
      Top = 9
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PON_CODPON'
      DataSource = dtsCadPon
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomPon: TDBEditFocus
      Tag = 99
      Left = 56
      Top = 32
      Width = 565
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PON_NOMPON'
      DataSource = dtsCadPon
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 46
      Top = 63
      Width = 659
      Height = 121
      Caption = 'Servi'#231'o de impress'#227'o:'
      TabOrder = 2
      object Label3: TLabel
        Left = 22
        Top = 32
        Width = 75
        Height = 14
        Caption = 'Endere'#231'o MAC:'
      end
      object Label4: TLabel
        Left = 22
        Top = 58
        Width = 106
        Height = 14
        Caption = 'Nome do Computador:'
      end
      object Label5: TLabel
        Left = 22
        Top = 85
        Width = 85
        Height = 14
        Caption = 'Nome do Usu'#225'rio:'
      end
      object lblEndMac: TLabel
        Left = 154
        Top = 32
        Width = 96
        Height = 14
        Caption = '00-15-5D-0A-0D-00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblNomMaq: TLabel
        Left = 154
        Top = 58
        Width = 65
        Height = 14
        Caption = 'TSPRG2018B'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblNomUsu: TLabel
        Left = 154
        Top = 85
        Width = 48
        Height = 14
        Caption = 'user.teste'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object btnGerTok: TSpeedButton
        Left = 340
        Top = 16
        Width = 285
        Height = 22
        Caption = '&Gerar Token para instala'#231#227'o do Spooler de Impress'#227'o'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF8484
          84FF848484FF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FFFFFF
          FFFF9D9D9DFFE6E6E6FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF9D9D
          9DFFE6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FFE6E6
          E6FFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFAFAFAFA7B7B7BDD1A1A1A3300000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF7B7B7BDD1A1A1A330000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF838383FE848484FF1A1A1A33000000000000000000000000}
        OnClick = btnGerTokClick
      end
      object btnLibTok: TSpeedButton
        Left = 340
        Top = 40
        Width = 285
        Height = 22
        Caption = '&Liberar ponto de impress'#227'o para nova instala'#231#227'o        '
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF848484FF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFD4B494FFD4B494FFD4B494FFD4B494FFD4B494FFD4B4
          94FFD4B494FFD4B494FFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFD4B494FFD4B494FFD4B494FFD4B494FFD4B494FFD4B4
          94FFD4B494FFD4B494FFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFD4B494FFD4B494FFD4B494FFD4B494FFD4B494FFD4B4
          94FFD4B494FFD4B494FFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF0000000000000000000000000000
          0000848484FFFFFFFFFFD4B494FFD4B494FFD4B494FFD4B494FFD4B494FFE5D2
          BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFB4C1EFFF4463D8FFFFFFFFFFFFFFFFFF4463D8FF1B285666000000000000
          0000848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFFFFF
          FFFF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF000000000000
          0000848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFFFFF
          FFFFFFFFFFFF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000000000
          0000848484FFFFFFFFFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFFFFF
          FFFFFFFFFFFF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000000000
          0000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF000000000000
          0000848484FF848484FF848484FF848484FF848484FF848484FF848484FFFFFF
          FFFFB4C1EFFF4463D8FF00000000000000004463D8FF1B285666}
        OnClick = btnLibTokClick
      end
    end
    object gpbEmpDis: TGroupBox
      Left = 46
      Top = 190
      Width = 659
      Height = 132
      Caption = 'Ponto de impress'#227'o dispon'#237'vel para as empresas:'
      TabOrder = 3
      object lblEmpDis: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 113
        Width = 649
        Height = 14
        Cursor = crHandPoint
        Align = alBottom
        Caption = 'Op'#231#245'es de Sele'#231#227'o'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblEmpDisClick
        ExplicitWidth = 95
      end
      object clbEmpDis: TCheckListBox
        Tag = 99
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 649
        Height = 88
        TabStop = False
        Align = alClient
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemHeight = 14
        TabOrder = 0
      end
    end
  end
  object dtsCadPon: TDataSource
    Left = 344
  end
  object popSelEmp: TPopupMenu
    Left = 660
    Top = 44
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
