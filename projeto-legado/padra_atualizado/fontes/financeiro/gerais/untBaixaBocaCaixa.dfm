inherited frmBaixaBocaCaixa: TfrmBaixaBocaCaixa
  Left = 176
  Top = 200
  Width = 803
  Height = 488
  Caption = 'Baixa de Boca de Caixa'
  Position = poScreenCenter
  ExplicitWidth = 803
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 418
    Width = 797
    TabOrder = 5
    ExplicitTop = 415
    ExplicitWidth = 797
    DesignSize = (
      797
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 793
      ExplicitWidth = 793
    end
  end
  inherited pgcDados: TPageControl
    Top = 45
    Width = 797
    Height = 373
    TabOrder = 2
    TabStop = False
    ExplicitTop = 45
    ExplicitWidth = 797
    ExplicitHeight = 370
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 789
      ExplicitHeight = 338
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 797
    Height = 45
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblVen: TLabel
      Left = 12
      Top = 18
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVendedor: TEditFocus
      Left = 114
      Top = 11
      Width = 407
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 418
    Width = 797
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 3
    object FlwBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 698
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitTop = 3
      ExplicitWidth = 793
      ExplicitHeight = 23
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 131
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 131
        Top = 0
        Width = 131
        Height = 21
        Caption = '[ F8 ] Marcar Todas'
        TabOrder = 1
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 262
        Top = 0
        Width = 131
        Height = 21
        Caption = '[ F7 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 700
      Top = 2
      Width = 95
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
  end
  object pnlAux1: TPanel [5]
    Left = 0
    Top = 45
    Width = 797
    Height = 373
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 370
    object pnlTotais: TPanel
      Left = 0
      Top = 294
      Width = 797
      Height = 79
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      ExplicitTop = 291
      object GroupBox1: TGroupBox
        Left = 8
        Top = 6
        Width = 382
        Height = 66
        Caption = 'SELECIONADOS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label6: TLabel
          Left = 7
          Top = 22
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Quantidade:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 7
          Top = 46
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Documentos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 212
          Top = 46
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Comiss'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtQtdSel: TEditFocus
          Left = 106
          Top = 14
          Width = 36
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValorSel: TEditFocus
          Left = 106
          Top = 38
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtComSel: TEditFocus
          Left = 297
          Top = 38
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object GroupBox2: TGroupBox
        Left = 403
        Top = 6
        Width = 382
        Height = 66
        Caption = 'GERAL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label2: TLabel
          Left = 7
          Top = 22
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Quantidade:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 7
          Top = 46
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Documentos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 212
          Top = 46
          Width = 81
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Comiss'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtQtdGer: TEditFocus
          Left = 106
          Top = 14
          Width = 36
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValorGer: TEditFocus
          Left = 106
          Top = 38
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtComGer: TEditFocus
          Left = 297
          Top = 38
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 797
      Height = 294
      Align = alClient
      DataSource = dtsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDocumentosDrawColumnCell
      OnDblClick = dbgDocumentosDblClick
      OnKeyDown = dbgDocumentosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMDOC'
          Title.Caption = 'Documento'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTAENT'
          Title.Caption = 'Dta Emiss'#227'o'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODITE'
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRI'
          Title.Caption = 'Descri'#231#227'o'
          Width = 215
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDAD'
          Title.Caption = 'Unid.'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtd'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRUNI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRTOT'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Total'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRCOM'
          Title.Caption = 'Valor Comiss'#227'o'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MARDES'
          ReadOnly = False
          Visible = False
        end>
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 797
    TabOrder = 4
    ExplicitTop = 443
    ExplicitWidth = 797
    inherited pnlNomeForm: TPanel
      Left = 626
      ExplicitLeft = 626
    end
    inherited pnlInfo: TPanel
      Width = 626
      ExplicitWidth = 626
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 584
  end
  object dtsGrid: TDataSource
    Left = 528
    Top = 80
  end
end
