inherited frmImendesProcessos: TfrmImendesProcessos
  Width = 1024
  Height = 676
  Caption = 'Processos - iMendes'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 676
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 603
    Width = 1018
    ExplicitTop = 603
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnAtualiza: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 23
        Caption = '[ F5 ] Atualiza'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000100000002000000080000000C0000000F0000000F0000000D0000
          0007000000040000000700000007000000020000000000000000000000000000
          0001000000050204031C102F2291184A34D31E5C41FF1E5B40FF184732D2112F
          227D0000000E14382995072C1B95000000090000000100000000000000010000
          00080A1C145722674CE723966DFF23B481FF24CA92FF39CF9DFF37886AFF0C21
          185D06100C392A7B5CFB146744FB020C08370000000400000000000000060D25
          1C652E8867FF28B586FF3BDAA8FF59E0B7FF6FE5C2FF5FC6A6FF1F533FBF0000
          00161E523DBF27B786FF1EB07DFF0C3E28BF0000000C00000001040A08223080
          62F62BBA8BFF42DDADFF65CEADFF53AB8EFF3A8B6EFF2F7D60FA07120D360E24
          1B5D2F9671FF28D59EFF28D59EFF1D805AFF051B125C00000005194434903CAC
          88FF2DDAA5FF5ECFAEFF45987CF914362A750409072002050415010302162B73
          57E12ACC98FF29D8A1FF2AD7A0FF26C592FF145438E00001010F2A7258D438C7
          9BFF30DDA9FF5CB699FF194133810000000700000001000000061941328460B8
          9CFF83ECCFFF2BDAA5FF34DBA8FF88EDD0FF479D7FFF0B2A1C77358C6DF250DF
          B6FF61E8C2FF3F9475FF040A081E00000002000000000205040F36896CF4378F
          70FF419A7BFF30DCA8FF38D7A7FF358A6BFF34886AFF317E61EF3B997AFA98ED
          D8FF8DF1D8FF398E6DFF040B0820000000010000000000000002000000070205
          04193F9675FF43E2B3FF4DDAB1FF1D6749F20000000F0000000734856AD398E1
          CFFF9AF4DEFF57A98BFF11382681000000060000000100000001000000051237
          287659B092FF8BF1D7FF6ECEB2FF1E6047D400000006000000002359478A81CF
          BAFFB4F9EAFF82D3BCFF3A8767FB0E352383030C0823030C08230E3222753D8E
          6EF984DFC7FFAAF6E5FF6FB8A0FF1642328C0000000300000000050D0A1855B2
          95F5A5E5D5FFBCFAEDFF94E5D0FF56A386FF2D7B59FF2D7B59FF54A386FF85D4
          BDFFB5F8EAFF9ADAC9FF419477F5030A0719000000010000000000000002173A
          2F5669C6AAFFAAE7D9FFCBFDF3FFC1FBEFFFBAF9ECFFB8F9EBFFBEFBEEFFC7FC
          F2FFA6E5D5FF5CB096FF12302657000000020000000000000000000000000000
          0002122E264453AB90E38AD7C2FFB2EADDFFCEF9F1FFCEF9F1FFB1EADCFF87D4
          BFFF50A78CE40F29204400000002000000000000000000000000000000000000
          0000000000010409070F255D4C813A9076C849B896FC49B795FC399075C8255B
          4A82030907100000000100000000000000000000000000000000000000000000
          0000000000000000000000000001000000020000000200000002000000020000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnAtualizaClick
      end
      object btnGerarNovaConsulta: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 144
        Height = 23
        Caption = '[ F6 ] Reprocessar Consulta'
        TabOrder = 1
        OnClick = btnGerarNovaConsultaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 631
    Width = 1018
    ExplicitTop = 631
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
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 603
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvData: TcxGridDBColumn
        Caption = 'Data/Hora'
        DataBinding.FieldName = 'DATA'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Editing = False
      end
      object cxvSituacao: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'STATUS'
        Options.Editing = False
      end
      object cxvEmpresa: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRESA'
        Options.Editing = False
      end
      object cxvDescricao: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRICAO'
        Options.Editing = False
        Width = 233
      end
      object cxvQtdErro: TcxGridDBColumn
        Caption = 'Qtd. Erros'
        DataBinding.FieldName = 'QTD_ERROS'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.AutoWidthSizable = False
      end
      object cxvProgresso: TcxGridDBColumn
        Caption = 'Progresso'
        DataBinding.FieldName = 'PROGRESSO'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.AutoWidthSizable = False
      end
      object cxvExcluir: TcxGridDBColumn
        Caption = 'Excluir'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Excluir'
            Default = True
            Kind = bkText
          end>
        Properties.UseLeftAlignmentOnEditing = False
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxvExcluirPropertiesButtonClick
        BestFitMaxWidth = 41
        HeaderAlignmentHorz = taCenter
        MinWidth = 55
        Width = 55
      end
      object cxvCarregar: TcxGridDBColumn
        Caption = 'Carregar'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Carregar'
            Default = True
            Kind = bkText
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxvCarregarPropertiesButtonClick
        BestFitMaxWidth = 51
        MinWidth = 51
        Width = 61
      end
      object cxvFinalizar: TcxGridDBColumn
        Caption = 'Finalizar'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Finalizar'
            Default = True
            Kind = bkText
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxvFinalizarPropertiesButtonClick
        BestFitMaxWidth = 64
        MinWidth = 64
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object dtsDados: TDataSource
    Left = 296
    Top = 128
  end
end
