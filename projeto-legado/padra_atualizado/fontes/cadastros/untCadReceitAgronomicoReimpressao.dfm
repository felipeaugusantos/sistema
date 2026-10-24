inherited frmCadReceitAgronomicoReimpressao: TfrmCadReceitAgronomicoReimpressao
  Width = 1024
  Height = 768
  Caption = 'Reimpress'#227'o de Receitu'#225'rio Agron'#244'mico'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 693
    Width = 1018
    ExplicitTop = 693
    ExplicitWidth = 1018
  end
  inherited pgcDados: TPageControl
    Left = 32358
    Top = 192
    Width = 73
    Height = 25
    Align = alNone
    Visible = False
    ExplicitLeft = 32358
    ExplicitTop = 192
    ExplicitWidth = 73
    ExplicitHeight = 25
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 15
    end
  end
  object pnlButtons: TPanel [3]
    Left = 0
    Top = 693
    Width = 1018
    Height = 31
    Align = alBottom
    BevelOuter = bvLowered
    BorderWidth = 3
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    object btnImprimir: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 165
      Height = 23
      Align = alLeft
      Caption = '[ F7 ] Reimprimir'
      TabOrder = 0
      OnClick = btnImprimirClick
    end
    object btnFechar: TBitBtnLocked
      Left = 942
      Top = 4
      Width = 72
      Height = 23
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      ModalResult = 2
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object dbgMovGro: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 693
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgMovGroDBTableView: TcxGridDBTableView
      OnMouseLeave = dbgMovGroDBTableViewMouseLeave
      OnMouseMove = dbgMovGroDBTableViewMouseMove
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgMovGroDBTableViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object dbgMovGroDBTableViewNUMREC: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'MGR_NUMREC'
        Width = 68
      end
      object dbgMovGroDBTableViewNOTFIS: TcxGridDBColumn
        Caption = 'Nota Fiscal'
        DataBinding.FieldName = 'MGR_NOTFIS'
        Width = 105
      end
      object dbgMovGroDBTableViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'MGR_CODITE'
        Width = 77
      end
      object dbgMovGroDBTableViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 252
      end
      object dbgMovGroDBTableViewCULTUR: TcxGridDBColumn
        Caption = 'Cultura'
        DataBinding.FieldName = 'MGR_CULTUR'
        Width = 114
      end
      object dbgMovGroDBTableViewARTIGO: TcxGridDBColumn
        Caption = 'Artigo'
        DataBinding.FieldName = 'MGR_ARTIGO'
        Width = 118
      end
      object dbgMovGroDBTableViewDIAGNO: TcxGridDBColumn
        Caption = 'Diagn'#243'stico'
        DataBinding.FieldName = 'MGR_DIAGNO'
        Width = 155
      end
      object dbgMovGroDBTableViewINTAPL: TcxGridDBColumn
        Caption = 'Intervalo/Apl.Padra.'
        DataBinding.FieldName = 'MGR_INTAPL'
        Width = 155
      end
      object dbgMovGroDBTableViewNOMCOM: TcxGridDBColumn
        Caption = 'Nome Comercial'
        DataBinding.FieldName = 'MGR_NOMCOM'
        Width = 170
      end
      object dbgMovGroDBTableViewGRUQUI: TcxGridDBColumn
        Caption = 'Grupo Qu'#237'mico'
        DataBinding.FieldName = 'MGR_GRUQUI'
        Width = 164
      end
      object dbgMovGroDBTableViewCLATOX: TcxGridDBColumn
        Caption = 'Classe Toxicol'#243'gica'
        DataBinding.FieldName = 'MGR_CLATOX'
        Width = 231
      end
      object dbgMovGroDBTableViewCONCEN: TcxGridDBColumn
        Caption = 'Concentra'#231#227'o'
        DataBinding.FieldName = 'MGR_CONCEN'
        Width = 218
      end
      object dbgMovGroDBTableViewPRIATI: TcxGridDBColumn
        Caption = 'Princ'#237'pio Ativo'
        DataBinding.FieldName = 'MGR_PRIATI'
        Width = 192
      end
      object dbgMovGroDBTableViewFORMUL: TcxGridDBColumn
        Caption = 'Formula'#231#227'o'
        DataBinding.FieldName = 'MGR_FORMUL'
        Width = 219
      end
      object dbgMovGroDBTableViewPERCAR: TcxGridDBColumn
        Caption = 'Per'#237'odo de Car'#234'ncia'
        DataBinding.FieldName = 'MGR_PERCAR'
        Width = 335
      end
      object dbgMovGroDBTableViewDOSAPL: TcxGridDBColumn
        Caption = 'Dosagem Aplica'#231#227'o'
        DataBinding.FieldName = 'MGR_DOSAPL'
        Width = 277
      end
      object dbgMovGroDBTableViewDOSESP: TcxGridDBColumn
        Caption = 'Especificada'
        DataBinding.FieldName = 'MGR_DOSESP'
        Width = 221
      end
      object dbgMovGroDBTableViewAREREC: TcxGridDBColumn
        Caption = #193'rea de Aplica'#231#227'o'
        DataBinding.FieldName = 'MGR_AREREC'
        Width = 232
      end
      object dbgMovGroDBTableViewNUMAPL: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'MGR_NUMAPL'
        Width = 239
      end
      object dbgMovGroDBTableViewTOTADQ: TcxGridDBColumn
        Caption = 'Total a Adquirir'
        DataBinding.FieldName = 'MGR_TOTADQ'
        Width = 219
      end
      object dbgMovGroDBTableViewMODAPL: TcxGridDBColumn
        Caption = 'Modalidade Aplica'#231#227'o'
        DataBinding.FieldName = 'MGR_MODAPL'
        Width = 331
      end
      object dbgMovGroDBTableViewEPOAPL: TcxGridDBColumn
        Caption = #201'poca de Aplica'#231#227'o'
        DataBinding.FieldName = 'MGR_EPOAPL'
        Width = 308
      end
      object dbgMovGroDBTableViewMANPRA: TcxGridDBColumn
        Caption = 'Manejo Integr. Pragas'
        DataBinding.FieldName = 'MGR_MANPRA'
        Width = 217
      end
      object dbgMovGroDBTableViewALARME: TcxGridDBColumn
        Caption = 'Sintomas/Alarmes'
        DataBinding.FieldName = 'MGR_ALARME'
        Width = 289
      end
      object dbgMovGroDBTableViewANTIDO: TcxGridDBColumn
        Caption = 'Ant'#237'doto / Tratamento'
        DataBinding.FieldName = 'MGR_ANTIDO'
        Width = 323
      end
      object dbgMovGroDBTableViewOBSERV: TcxGridDBColumn
        Caption = 'Observa'#231#245'es'
        DataBinding.FieldName = 'MGR_OBSERV'
        Width = 431
      end
    end
    object dbgMovGroLevel: TcxGridLevel
      GridView = dbgMovGroDBTableView
    end
  end
  inherited pnlStatus: TPanel
    Top = 724
    Width = 1018
    ExplicitTop = 724
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 16
  end
end
