inherited frmMandaeEnvioEncomendas: TfrmMandaeEnvioEncomendas
  Left = 0
  Top = 0
  Width = 834
  Height = 328
  BorderIcons = [biSystemMenu]
  Caption = 'Despacho de Mercadorias - Envio de Encomendas Manda'#234
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 834
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 255
    Width = 828
    ExplicitTop = 255
    ExplicitWidth = 828
    inherited FlwBotoes: TFlowPanel
      Width = 824
      ExplicitWidth = 824
      object btnEnviarDocumentos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 137
        Height = 22
        Caption = '[F10] Enviar Documentos '
        TabOrder = 0
        OnClick = btnEnviarDocumentosClick
      end
      object btnConsultarEnviados: TBitBtnLocked
        Left = 137
        Top = 0
        Width = 137
        Height = 22
        Caption = '[F6] Consultar Enviados '
        TabOrder = 1
        OnClick = btnConsultarEnviadosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 740
      Top = 2
      ExplicitLeft = 740
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 283
    Width = 828
    ExplicitTop = 283
    ExplicitWidth = 828
    inherited pnlNomeForm: TPanel
      Left = 657
      ExplicitLeft = 657
    end
    inherited pnlInfo: TPanel
      Width = 657
      ExplicitWidth = 657
    end
  end
  object Panel3: TPanel [3]
    Left = 0
    Top = 0
    Width = 828
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object grdDocumentos: TcxGridCitel
      Left = 0
      Top = 0
      Width = 828
      Height = 255
      Align = alClient
      TabOrder = 0
      object grdDbDocumentos: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDocumentos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdDbDocumentosColumn1: TcxGridDBColumn
          Caption = 'Data\Hora Documento'
          DataBinding.FieldName = 'MAN_DTADOC'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 138
        end
        object grdDbDocumentosColumn2: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'MAN_NUMDOC'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 102
        end
        object grdDbDocumentosColumn3: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'MAN_ESPDOC'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 55
        end
        object grdDbDocumentosColumn6: TcxGridDBColumn
          Caption = 'Volume'
          DataBinding.FieldName = 'MAN_VOLUME'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
        end
        object grdDbDocumentosColumn4: TcxGridDBColumn
          Caption = 'C'#243'digo do Rastreio'
          DataBinding.FieldName = 'MAN_CODRAS'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 111
        end
        object grdDbDocumentosColumn5: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'MAN_MENINT'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 326
        end
      end
      object grdDocumentosLevel1: TcxGridLevel
        GridView = grdDbDocumentos
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 600
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 104
  end
  object dtsDocumentos: TDataSource
    Left = 49
    Top = 88
  end
end
