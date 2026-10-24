inherited frmGarantiaAltPrecosEnvFornecedor: TfrmGarantiaAltPrecosEnvFornecedor
  Width = 621
  Height = 454
  Caption = 'Garantia - Altera'#231#227'o de Pre'#231'os Envio Fornecedor'
  ExplicitWidth = 621
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 615
    TabOrder = 2
    ExplicitTop = 381
    ExplicitWidth = 615
    DesignSize = (
      615
      28)
    inherited btnSair: TBitBtnLocked
      Left = 494
      Width = 117
      Caption = '[ ESC ] &Cancelar'
      ExplicitLeft = 494
      ExplicitWidth = 117
    end
    inherited btnConfirma: TBitBtnLocked
      Width = 121
      Caption = '[ F10 ] &Confirma'
      ExplicitWidth = 121
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 344
    Width = 615
    Height = 37
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lbl1: TLabel
      Left = 392
      Top = 13
      Width = 95
      Height = 16
      Alignment = taRightJustify
      Caption = 'Total dos Itens:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotGer: TDBEditFocus
      Left = 490
      Top = 7
      Width = 100
      Height = 24
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTITE'
      DataSource = dtsItens
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 615
    Height = 344
    Hint = 
      'ESC: Voltar ao c'#243'digo do item'#13#10'ENTER: Alterar Item'#13#10'DELETE: Dele' +
      'ta o item'#13#10'CTRL + CIMA: Mover item para cima'#13#10'CTRL + BAIXO: Move' +
      'r item para baixo'
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnColEnter = dbgItensColEnter
    OnDrawColumnCell = dbgItensDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_ORDITE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'N'#186
        Width = 18
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 269
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quant.'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SIGUNI'
        ReadOnly = True
        Title.Caption = 'Unid.'
        Width = 28
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pr. Unit'#225'rio'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Total'
        Width = 75
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 409
    Width = 615
    TabOrder = 3
    ExplicitTop = 409
    ExplicitWidth = 615
    inherited pnlNomeForm: TPanel
      Left = 444
      ExplicitLeft = 444
    end
    inherited pnlInfo: TPanel
      Width = 444
      ExplicitWidth = 444
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 344
    Top = 80
  end
end
