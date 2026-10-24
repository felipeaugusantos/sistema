inherited frmBaixaVolumes: TfrmBaixaVolumes
  Width = 746
  Height = 438
  Caption = 'Baixa de Volumes / Embalagem'
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 746
  ExplicitHeight = 438
  PixelsPerInch = 96
  TextHeight = 14
  object Bevel1: TBevel [0]
    Left = 0
    Top = 33
    Width = 740
    Height = 7
    Align = alTop
    Shape = bsTopLine
    ExplicitTop = 28
  end
  object pnlDadosNota: TPanel [1]
    Left = 0
    Top = 40
    Width = 740
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 6
    object Label2: TLabel
      Left = 5
      Top = 0
      Width = 87
      Height = 29
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbtNomCli: TDBText
      Left = 98
      Top = 0
      Width = 642
      Height = 29
      DataField = 'NOMCLI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 1
      Top = 30
      Width = 740
      Height = 7
      Shape = bsTopLine
    end
    object Label3: TLabel
      Left = 5
      Top = 35
      Width = 183
      Height = 29
      Caption = 'Transportadora:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbtNomTra: TDBText
      Left = 194
      Top = 35
      Width = 546
      Height = 29
      DataField = 'NOMTRA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 1
      Top = 67
      Width = 740
      Height = 7
      Shape = bsTopLine
    end
    object Label4: TLabel
      Left = 5
      Top = 72
      Width = 105
      Height = 29
      Caption = 'Volumes:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbtVolume: TDBText
      Left = 116
      Top = 72
      Width = 141
      Height = 29
      DataField = 'VOLUME'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel4: TBevel
      Left = 1
      Top = 102
      Width = 740
      Height = 7
      Shape = bsTopLine
    end
  end
  inherited pnlBotoes: TPanel
    Top = 365
    Width = 740
    TabOrder = 3
    ExplicitTop = 365
    ExplicitWidth = 740
    inherited FlwBotoes: TFlowPanel
      Top = 2
      Width = 736
      Height = 24
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 736
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 87
        Height = 22
        Align = alLeft
        Caption = '&Confirma'
        Enabled = False
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 655
      Top = 2
      Width = 82
      ExplicitLeft = 655
      ExplicitTop = 2
      ExplicitWidth = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 393
    Width = 740
    TabOrder = 4
    ExplicitTop = 393
    ExplicitWidth = 740
    inherited pnlNomeForm: TPanel
      Left = 569
      ExplicitLeft = 569
    end
    inherited pnlInfo: TPanel
      Width = 569
      ExplicitWidth = 569
    end
  end
  object pnlTop: TPanel [5]
    Left = 0
    Top = 0
    Width = 740
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 13
      Top = 9
      Width = 89
      Height = 14
      Caption = 'Chave de Acesso:'
    end
    object edtAcesso: TEditFocus
      Tag = 99
      Left = 108
      Top = 6
      Width = 331
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgDados: TDBGridCitel [6]
    Left = 0
    Top = 175
    Width = 740
    Height = 190
    TabStop = False
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = True
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMOBJ'
        Title.Caption = 'N'#250'mero do Objeto'
        Width = 202
        Visible = True
      end>
  end
  object pnlColeta: TPanel [7]
    Left = 0
    Top = 145
    Width = 740
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label5: TLabel
      Left = 13
      Top = 7
      Width = 89
      Height = 14
      Caption = 'Numero do Objeto:'
    end
    object edtNumObj: TEditFocus
      Tag = 99
      Left = 106
      Top = 4
      Width = 175
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1070
    Top = 146
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1022
    Top = 82
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 950
    Top = 106
  end
end
