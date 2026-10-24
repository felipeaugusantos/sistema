inherited frmCadMatrizBasesDifal: TfrmCadMatrizBasesDifal
  Width = 569
  Height = 378
  Caption = 'Matriz de Bases do Difal'
  ExplicitWidth = 569
  ExplicitHeight = 378
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 305
    Width = 563
    ExplicitTop = 305
    ExplicitWidth = 563
    inherited FlwBotoes: TFlowPanel
      Width = 559
      ExplicitTop = 2
      ExplicitWidth = 559
      inherited btnPesquisa: TBitBtnLocked
        Width = 81
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 476
      ExplicitLeft = 476
    end
  end
  inherited pgcDados: TPageControl
    Left = 244
    Top = 108
    Width = 252
    Height = 130
    Align = alNone
    ExplicitLeft = 244
    ExplicitTop = 108
    ExplicitWidth = 252
    ExplicitHeight = 130
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 244
      ExplicitHeight = 98
    end
  end
  inherited pnlStatus: TPanel
    Top = 333
    Width = 563
    ExplicitTop = 333
    ExplicitWidth = 563
    inherited pnlNomeForm: TPanel
      Left = 216
      ExplicitLeft = 216
    end
    inherited pnlInfo: TPanel
      Width = 216
      ExplicitWidth = 216
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 0
    Width = 563
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 45
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 29
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodMat: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 8
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIF_CODMAT'
      DataSource = dscMATDIF
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
    object dbeDesMat: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 31
      Width = 447
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIF_DESCRI'
      DataSource = dscMATDIF
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
    object dbgMatrizBasesDifal: TDBGridCitel
      Left = 0
      Top = 59
      Width = 563
      Height = 246
      Align = alBottom
      DataSource = dscDIFBAS
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = True
      DestacarMouse = False
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DIF_ESTADO'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Estado'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DIF_ORIPER'
          Title.Alignment = taRightJustify
          Title.Caption = 'Base Difal Origem (%)'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DIF_DESPER'
          Title.Alignment = taRightJustify
          Title.Caption = 'Base Difal Destino (%)'
          Width = 150
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 500
    Top = 68
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 468
    Top = 68
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 404
    Top = 68
  end
  object dscMATDIF: TDataSource
    Left = 372
    Top = 68
  end
  object cdsDIFBAS: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'DIF_ESTADO'
    Params = <>
    Left = 272
    Top = 176
    object cdsDIFBASAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDIFBASDIF_CODMAT: TStringField
      FieldName = 'DIF_CODMAT'
      Size = 3
    end
    object cdsDIFBASDIF_ESTADO: TStringField
      FieldName = 'DIF_ESTADO'
      Size = 2
    end
    object cdsDIFBASDIF_ORIPER: TFloatField
      FieldName = 'DIF_ORIPER'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDIFBASDIF_DESPER: TFloatField
      FieldName = 'DIF_DESPER'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dscDIFBAS: TDataSource
    DataSet = cdsDIFBAS
    Left = 272
    Top = 224
  end
end
