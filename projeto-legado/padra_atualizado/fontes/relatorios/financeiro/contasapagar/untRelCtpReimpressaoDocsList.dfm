inherited frmRelCtpReimpressaoDocsList: TfrmRelCtpReimpressaoDocsList
  Width = 596
  Height = 361
  Caption = 'Reimpress'#227'o de Contas a Pagar'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 596
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 291
    Width = 590
    Height = 25
    TabOrder = 1
    ExplicitTop = 291
    ExplicitWidth = 590
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 509
      Height = 21
      ExplicitWidth = 509
      ExplicitHeight = 21
      object btnBusca: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F3 ] Busca'
        TabOrder = 0
        OnClick = btnBuscaClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 119
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F7 ] Marcar todas'
        TabOrder = 1
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 238
        Top = 0
        Width = 131
        Height = 21
        Caption = '[ F8 ] Desmarcar todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 369
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 3
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 511
      Top = 2
      Height = 21
      Align = alRight
      ExplicitLeft = 511
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 316
    Width = 590
    TabOrder = 2
    ExplicitTop = 316
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 419
      ExplicitLeft = 419
    end
    inherited pnlInfo: TPanel
      Width = 419
      ExplicitWidth = 419
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 590
    Height = 291
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblSelecione: TLabel
      Left = 2
      Top = 2
      Width = 586
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Selecione o documento desejado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 213
    end
    object dbgDocumentos: TDBGridCitel
      Left = 2
      Top = 18
      Width = 586
      Height = 271
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CTP_DTACAD'
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTP_NUMDUP'
          Title.Caption = 'Documento'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTP_PARCEL'
          Title.Caption = 'Parcela'
          Width = 41
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTP_CODEMP'
          Title.Caption = 'EMP'
          Width = 24
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FOR_NOMFOR'
          Title.Caption = 'Fornecedor'
          Width = 206
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTP_VALPAG'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 77
          Visible = True
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
end
