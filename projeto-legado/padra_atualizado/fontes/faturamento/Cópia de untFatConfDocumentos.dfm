inherited frmFatConfPedidos: TfrmFatConfPedidos
  Left = 0
  Top = 0
  Width = 734
  Height = 557
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Pedidos'
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 726
    inherited btnSair: TBitBtn
      Left = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 726
    inherited pnlNomeForm: TPanel
      Left = 541
      Width = 185
    end
    inherited pnlInfo: TPanel
      Width = 541
    end
  end
  inherited pgcDados: TPageControl
    Left = 473
    Top = 43
    Width = 253
    Height = 440
    Visible = False
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 726
    Height = 43
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 35
      Top = 18
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 74
      Top = 11
      Width = 72
      Height = 22
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtNomCli: TEditFocus
      Left = 148
      Top = 11
      Width = 569
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 43
    Width = 473
    Height = 440
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 473
      Height = 440
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDocumentosDrawColumnCell
      OnDblClick = dbgDocumentosDblClick
      OnKeyDown = dbgDocumentosKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_DTAENT'
          Title.Caption = 'Dta. Emiss'#227'o'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODVEN'
          Title.Caption = 'Vendedor'
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_NUMDOC'
          Title.Caption = 'Documento'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ESPDOC'
          Title.Caption = 'Esp.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODEMP'
          Title.Caption = 'Emp.'
          Width = 30
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Total'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_ITEDOC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Itens'
          Visible = True
        end>
    end
  end
  object pnlAux1: TPanel [5]
    Left = 473
    Top = 43
    Width = 253
    Height = 440
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 253
      Height = 176
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label4: TLabel
        Left = 2
        Top = 2
        Width = 249
        Height = 23
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 17
        Top = 56
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label11: TLabel
        Left = 55
        Top = 77
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDoc: TEditFocus
        Left = 114
        Top = 47
        Width = 72
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object edtTotLiq: TEditFocus
        Left = 114
        Top = 70
        Width = 72
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 176
      Width = 253
      Height = 264
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 249
        Height = 31
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 18
        Top = 57
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label17: TLabel
        Left = 55
        Top = 81
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 114
        Top = 50
        Width = 72
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object edtTotLiqSel: TEditFocus
        Left = 114
        Top = 73
        Width = 72
        Height = 22
        TabStop = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 483
    Width = 726
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 6
    object btnItensDoc: TBitBtn
      Left = 4
      Top = 5
      Width = 137
      Height = 22
      Caption = '[ F5 ] Itens do Documento'
      TabOrder = 0
      OnClick = btnItensDocClick
    end
    object btnConfirma: TBitBtn
      Left = 143
      Top = 5
      Width = 129
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnSairConf: TBitBtn
      Left = 609
      Top = 5
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairConfClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 144
  end
end
