inherited frmCadMatrizAliquotasFCP: TfrmCadMatrizAliquotasFCP
  Width = 760
  Height = 249
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Cadastro de Matriz de Al'#237'quotas de FCP'
  ExplicitWidth = 760
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 176
    Width = 754
    ExplicitTop = 176
    ExplicitWidth = 872
    inherited FlwBotoes: TFlowPanel
      Width = 679
      ExplicitTop = 2
      ExplicitWidth = 797
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 682
      Width = 69
      Height = 23
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      ExplicitLeft = 800
      ExplicitWidth = 69
      ExplicitHeight = 23
    end
  end
  inherited pgcDados: TPageControl
    Width = 754
    Height = 176
    ExplicitWidth = 872
    ExplicitHeight = 176
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 864
      ExplicitHeight = 144
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 754
    Height = 176
    Align = alClient
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 872
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 752
      Height = 61
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 870
      object Label4: TLabel
        Left = 36
        Top = 36
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 52
        Top = 12
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object dbeDescricao: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 32
        Width = 568
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FCP_DESCRI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodMat: TDBEditFocus
        Tag = 99
        Left = 89
        Top = 8
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FCP_CODMAT'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
    object pnlMatriz: TPanel
      Left = 1
      Top = 62
      Width = 752
      Height = 113
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 870
      object pnlOrigem: TPanel
        Left = 1
        Top = 1
        Width = 750
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        ExplicitWidth = 868
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 754
          Height = 41
          Align = alLeft
          Alignment = taCenter
          AutoSize = False
          Caption = 'D E S T I N O'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -31
          Font.Name = 'Arial Black'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 55
          ExplicitHeight = 44
        end
      end
      object dbgAlqFCP: TDBGridCitel
        AlignWithMargins = True
        Left = 11
        Top = 45
        Width = 737
        Height = 64
        Margins.Left = 10
        Align = alClient
        BorderStyle = bsNone
        Color = 16770261
        DataSource = dtsFCPAlq
        DrawingStyle = gdsClassic
        FixedColor = cl3DLight
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Options = [dgEditing, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = [fsBold]
        OnDrawColumnCell = dbgAlqFCPDrawColumnCell
        OnEnter = dbgAlqFCPEnter
        OnKeyDown = dbgAlqFCPKeyDown
        OnKeyPress = dbgAlqFCPKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 204
    Width = 754
    ExplicitTop = 204
    ExplicitWidth = 872
    inherited pnlNomeForm: TPanel
      Left = 407
      ExplicitLeft = 525
    end
    inherited pnlInfo: TPanel
      Width = 407
      ExplicitWidth = 525
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 264
  end
  object dtsFCPAlq: TDataSource
    Left = 672
    Top = 196
  end
  object dtsTabela: TDataSource
    Left = 673
    Top = 261
  end
end
