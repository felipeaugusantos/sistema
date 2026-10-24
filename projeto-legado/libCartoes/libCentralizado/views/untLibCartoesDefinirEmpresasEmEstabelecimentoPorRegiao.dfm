inherited frmDefinirEmpresasEmEstabelecimentoPorRegiao: TfrmDefinirEmpresasEmEstabelecimentoPorRegiao
  Width = 1024
  Height = 600
  BorderIcons = []
  Caption = 'Definir empresas em estabelecimentos por regi'#227'o'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 533
    Width = 1018
    Height = 22
    BevelInner = bvNone
    BevelOuter = bvNone
    Enabled = True
    TabOrder = 4
    Visible = True
    ExplicitTop = 533
    ExplicitWidth = 1018
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 935
      Height = 22
      ExplicitLeft = -3
      ExplicitTop = -6
      ExplicitWidth = 935
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Caption = '&Confirma'
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
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 938
      Top = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      ExplicitLeft = 938
      ExplicitTop = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 728
      Width = 290
      ExplicitLeft = 728
      ExplicitWidth = 290
    end
    inherited pnlInfo: TPanel
      Width = 728
      ExplicitWidth = 728
    end
  end
  object dbgConsulta: TcxGridCitel [2]
    Left = 0
    Top = 25
    Width = 1018
    Height = 508
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgConsultaDados: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = dbgConsultaDadosEditKeyPress
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Bands = <
        item
        end
        item
          Caption = 'Selecionar empresa'
          FixedKind = fkRight
          Width = 484
        end>
      object dbgConsultaDadosNUMLIBERACAO: TcxGridDBBandedColumn
        Caption = 'N'#186' Libera'#231#227'o'
        DataBinding.FieldName = 'NUMLIBERACAO'
        Options.Editing = False
        Options.Focusing = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object dbgConsultaDadosNSU: TcxGridDBBandedColumn
        DataBinding.FieldName = 'NSU'
        Options.Editing = False
        Options.Focusing = False
        Width = 120
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object dbgConsultaDadosVENCIMENTO: TcxGridDBBandedColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'DtaVencimento'
        Options.Editing = False
        Options.Focusing = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object dbgConsultaDadosCADASTRO: TcxGridDBBandedColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'DtaCadastro'
        Options.Editing = False
        Options.Focusing = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object dbgConsultaDadosVALOR: TcxGridDBBandedColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'VALORTOTAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        FooterAlignmentHorz = taRightJustify
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object dbgConsultaDadosVALORSEMTAXA: TcxGridDBBandedColumn
        Caption = 'Valor sem taxa'
        DataBinding.FieldName = 'ValorSemTaxa'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        FooterAlignmentHorz = taRightJustify
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object dbgConsultaDadosPARCELA: TcxGridDBBandedColumn
        Caption = 'Parc.'
        DataBinding.FieldName = 'PARCELA'
        Options.Editing = False
        Options.Focusing = False
        Width = 35
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object dbgConsultaDadosCODEMPRESA: TcxGridDBBandedColumn
        Caption = 'C'#243'digo da empresa'
        DataBinding.FieldName = 'CodigoEmpresa'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.MaxLength = 3
        Properties.ValidationOptions = []
        Properties.OnEditValueChanged = dbgConsultaDadosCODEMPRESAPropertiesEditValueChanged
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object dbgConsultaDadosNOMEEMPRESA: TcxGridDBBandedColumn
        Caption = 'Nome da empresa'
        DataBinding.FieldName = 'NomeEmpresa'
        Options.Editing = False
        Options.Focusing = False
        Width = 384
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object dbgConsultaNivel: TcxGridLevel
      GridView = dbgConsultaDados
    end
  end
  object pnlMensagem: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblMensagem: TLabel
      Left = 3
      Top = 5
      Width = 938
      Height = 16
      Alignment = taCenter
      Caption = 
        'ATEN'#199#195'O: Para os cancelamentos/ajustes em que o c'#243'digo estabelec' +
        'imento da operadora est'#225' definido na CFG_CIEREG, deve ser defini' +
        'do a empresa da baixa:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited pgcDados: TPageControl
    Left = 3000
    Top = 169
    Width = 1018
    Height = 508
    Align = alNone
    Visible = False
    ExplicitLeft = 3000
    ExplicitTop = 169
    ExplicitWidth = 1018
    ExplicitHeight = 508
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 476
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 152
  end
end
