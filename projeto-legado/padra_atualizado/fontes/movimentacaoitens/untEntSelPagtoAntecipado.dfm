inherited frmEntSelPagtoAntecipado: TfrmEntSelPagtoAntecipado
  Width = 1122
  Height = 381
  Caption = 'Selecione os pagamentos antecipados'
  ExplicitWidth = 1122
  ExplicitHeight = 381
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 300
    Width = 1106
    Height = 26
    ExplicitTop = 284
    ExplicitWidth = 1034
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1025
      Height = 22
      ExplicitWidth = 953
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 101
        ExplicitWidth = 101
      end
      object btnConfirma: TBitBtnLocked
        Left = 219
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F10 ] Confirma'
        Enabled = False
        ModalResult = 1
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 337
        Top = 0
        Width = 173
        Height = 22
        Caption = '[ ESPA'#199'O ] Marca/Desmarca'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1027
      Top = 2
      Align = alRight
      ModalResult = 2
      ExplicitLeft = 955
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 326
    Width = 1106
    ExplicitTop = 310
    ExplicitWidth = 1034
    inherited pnlNomeForm: TPanel
      Left = 935
      ExplicitLeft = 863
    end
    inherited pnlInfo: TPanel
      Width = 935
      ExplicitWidth = 863
    end
  end
  inherited pnlHeader: TPanel
    Width = 1106
    Height = 25
    Visible = False
    ExplicitWidth = 1034
    ExplicitHeight = 25
  end
  inherited pnlTail: TPanel
    Top = 268
    Width = 1106
    Height = 32
    Visible = True
    ExplicitTop = 252
    ExplicitWidth = 1034
    ExplicitHeight = 32
    object lblTotNot: TLabel
      Left = 154
      Top = 8
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total da Nota:'
    end
    object Label1: TLabel
      Left = 311
      Top = 12
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total selecionado:'
    end
    object edtVlrCon: TEditFocus
      Left = 222
      Top = 4
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotSel: TEditFocus
      Left = 403
      Top = 4
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 65
    Width = 1106
    Height = 203
    Columns = <
      item
        Expanded = False
        FieldName = 'FOR_CODFOR'
        Title.Caption = 'Fornecedor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFAN'
        Title.Caption = 'Nome Fantasia'
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_C_G_C_'
        Title.Caption = 'CNPJ/CPF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_DTACAD'
        Title.Caption = 'Data Cadastro'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_DTAPAG'
        Title.Caption = 'Data Pagamento'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_NUMDUP'
        Title.Caption = 'Documento'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_PARCEL'
        Title.Caption = 'Parcela'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_HISTOR'
        Title.Alignment = taCenter
        Title.Caption = 'Hist'#243'rico'
        Width = 158
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTP_SERIE_'
        Title.Caption = 'S'#233'rie'
        Width = 31
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTP_VALPAG'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Pago'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GUI_DESCRI'
        Title.Caption = 'Tipo Guia'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 25
    Width = 1106
    ExplicitTop = 25
    ExplicitWidth = 1034
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 152
  end
end
