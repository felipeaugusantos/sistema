object frmRelCartaoExtratoConfirmacao: TfrmRelCartaoExtratoConfirmacao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 112
  Width = 364
  object frxExtratoCartoes: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 45119.688416365700000000
    ReportOptions.LastChange = 45352.460573078700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure MasterDataExtratoCartoesOnBeforePrint(Sender: TfrxComp' +
        'onent);'
      'begin'
      
        '  PicConfirmado.Visible    := (<frxDBExtratoCartoes."EXT_STATUS"' +
        '> = '#39'C'#39');'
      
        '  PicSimilar.Visible       := (<frxDBExtratoCartoes."EXT_STATUS"' +
        '> = '#39'S'#39');'
      
        '  PicDivTaxa.Visible       := (<frxDBExtratoCartoes."EXT_STATUS"' +
        '> = '#39'T'#39');'
      
        '  PicDivValorBruto.Visible := (<frxDBExtratoCartoes."EXT_STATUS"' +
        '> = '#39'B'#39');'
      
        '  PicNConfirmado.Visible   := (<frxDBExtratoCartoes."EXT_STATUS"' +
        '> = '#39'N'#39');'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 32
    Top = 36
    Datasets = <
      item
        DataSet = frxDBExtratoCartoes
        DataSetName = 'frxDBExtratoCartoes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 69.866110000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 17.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EXTRATO DE CART'#213'ES PARA CONFIRMA'#199#195'O')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 1241.757700000000000000
          Width = 115.200000000000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 1308.655350000000000000
          Top = 16.000000000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 1245.753000000000000000
          Top = 16.000000000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baCenter
          Left = 119.924645000000000000
          Width = 478.261410000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 668.847620000000000000
          Top = 0.220469999999998800
          Width = 48.302350000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 605.945270000000000000
          Top = 0.220469999999998800
          Width = 60.547990000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baCenter
          Left = 119.924645000000000000
          Top = 32.795300000000000000
          Width = 478.261410000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_NOMCON"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo98: TfrxMemoView
          Left = 498.897806220000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo99: TfrxMemoView
          Align = baLeft
          Left = 415.748187720000100000
          Width = 83.149618500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Transa'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo101: TfrxMemoView
          Align = baLeft
          Left = 332.598566780000100000
          Width = 83.149620940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo103: TfrxMemoView
          Align = baLeft
          Left = 291.023736780000100000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo104: TfrxMemoView
          Align = baLeft
          Left = 188.976463390000000000
          Width = 102.047273390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'NSU')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo105: TfrxMemoView
          Left = 642.519897400000000000
          Width = 75.590546300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Align = baLeft
          Left = 113.385900000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Libera'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '       Estabelecimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 574.488560000000000000
          Width = 68.031491180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Taxa')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterDataExtratoCartoes: TfrxMasterData
        FillType = ftBrush
        Height = 21.566936460000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterDataExtratoCartoesOnBeforePrint'
        DataSet = frxDBExtratoCartoes
        DataSetName = 'frxDBExtratoCartoes'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 21.566936460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clActiveCaption
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 498.897806220000000000
          Top = 3.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_VALBRU"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 415.748187720000000000
          Top = 3.000000000000000000
          Width = 83.149618500000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_DTACUP"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 332.598566780000000000
          Top = 3.000000000000000000
          Width = 83.149620940000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_DTAVEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 291.023736780000000000
          Top = 3.000000000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataField = 'EXT_PARCEL'
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_PARCEL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 188.976463390000000000
          Top = 3.000000000000000000
          Width = 102.047273390000000000
          Height = 15.118120000000000000
          DataField = 'EXT_NUMNSU'
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_NUMNSU"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 642.519897400000000000
          Top = 3.000000000000000000
          Width = 75.590546300000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_VALLIQ"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 113.385900000000000000
          Top = 3.000000000000000000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          DataField = 'EXT_CODAUT'
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_CODAUT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 34.015770000000000000
          Top = 3.000000000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_NUM_PV"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 574.488560000000000000
          Top = 3.000000000000000000
          Width = 68.031491180000000000
          Height = 15.118120000000000000
          DataSet = frxDBExtratoCartoes
          DataSetName = 'frxDBExtratoCartoes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBExtratoCartoes."EXT_VALTAX"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object PicConfirmado: TfrxPictureView
          Left = 7.559060000000000000
          Top = 2.267716535433067000
          Width = 16.000000000000000000
          Height = 16.000000000000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          AutoSize = True
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF610000001974455874536F6674776172650041646F
            626520496D616765526561647971C9653C0000000B744558745469746C650054
            61736B3BD380CA7C0000028F4944415478DA9DD36F4813611C07F0AFA09B6144
            BD8846499852946611AEB6821199A533FF900AD60B154C422C4B961908611004
            9265D2428A300DD35C666996BA9CD5A61999DA9F2357AB6891512122D676BBBB
            DD3DDD0E959E5EF8A21F3C7C9FE777F7FB1C1C3C418410FC5D66B3199C8F03EF
            E33B588E4D6579161CCBDF63596F1ACF0B6868A8A7DE0F9A058E5FB4DA44498A
            174509922461F1F473E8F53A78BD5E587BACE03509509EC94BCEBE96AA9C9D14
            60AAE926DBB6AE85CBD60C9665A19B19F67ABCF0783C70381C10043FD6679482
            1972A2B53A2F88024ACEDF2769693AE0CB6B7475F580E37C60792F785600CF73
            F2B080CCCC4C7C9B54A3FFFD14EED4E4D340F1D94E9292AE43E29AA56018064E
            A713212121CA52A95450ABD5583636064B701486863FA3FDD2011A28AA6C27C9
            A93AA4446B94B3CBE582DBED56060380A7AD0DE15151A85B1407E6C9303A6B0F
            D240E199BB2431650BF66E583EF787C7C7C731313181298B05BF0606B0C76683
            A96918EF1C237870A590060A4EDF26BB9275C88E0BC7DBEA6AFC900762CBCAE0
            EEEDC5A7DA5A6C6E6A4284C180A2BA417C783A0AEBD5221AC83FD54A76246991
            A38F005355A520B3B52A3717B11515080D0D45C1E57EB89FBDC4C36B876920EF
            A48518766B51608854CEB3C8028D0646BB1DC161614A3FD76CC7D7A157E86B28
            A6819CF266A24FD0E250FCEAB92F0790253131586134CEF5F65D7884EF2FDEE0
            71E3111AD87FA29168E3E3702C711DE6ABAC73BDF839C2C07EA38406B24BAF93
            8DDB37A13C35765E20BDD28AC951068E9B261AC832D59395D191502D0C032788
            E07811BC9CBC184809829C7E91C037358DDF1FDD1868F907C8385AD7E5F74B49
            818BA45C1825C9CC5E4E2281047A81BD44BA076F951A29E07FEB0F373E75F01A
            C04A4F0000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object PicSimilar: TfrxPictureView
          Left = 7.559055120000000000
          Top = 2.267716535433067000
          Width = 16.000000000000000000
          Height = 16.000000000000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          AutoSize = True
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000017352474200AECE1CE90000000467414D
            410000B18F0BFC610500000026744558745469746C650046696E643B42617273
            3B526962626F6E3B5374616E646172643B536561726368BB659C080000031B49
            44415478DAA5937B48935118C69F6F4ED7CC34338C4A5D866994913782693542
            2DD3249125E66526A206D342BBD02AA8BC646A99D8BAA0595129A51252AEBC6D
            61A59932CB2CDDA6D3A6E9ECA64D4D3FE72E7D0BFF29FACF033F389CF73DCF7B
            0EEFFB1046A3110B59C43F7B330A1A8549554F61F84FDE5F1509C12511728E84
            D062F879CEF60E2E42331ADD7F768E7C3EA8E83C547D375B792CA77215936973
            D540C34EBD4E573F39F69D2FCCE20DA5E7541B0B046120D22F54A3E044182325
            A3E27964B0377BF952265AA47DE8908D6A856722EC4E17D57E0FE5AC67D85A33
            216EEE825C35F1B2F054F88E9433957AE1B97D7F9E46E3C66773367B794B1223
            FDA0E81FC1EBB677508EE8519C13E5763CBF469E1AB315D3335AB4BCE982B4FB
            0B3453E3BEF72EF35B4DDF310930A20F5F2B0D0FF28DF6727782AC5F0D914882
            2EE538A6273558CD6221F754148C0623A4EFE578D9DA834912B7CA0A1393A9BB
            3AC275B3BFA3EFCE03BD479302195A9D017D9FD4A8A991A04F3501073B267EC1
            1C99021E2CE80464CA6134BD68C3D7091A29EBA8637536577D2342E3F2EF4684
            716243FC376189A505063EFFC09DFB3568782507313D0EEBD52CE49F4D80D30A
            1B58599AE3A36208B94595500D7F2969155DE2137B1384E4D5EC584653AB0A8F
            1A65E0066F809DE52C8E65DC8746DD0BC7F53E28BF9E0649F3201E35F4223CD8
            15D6740DB20A1E90D2C62BCB88A0E8C2B9AA9283F4E4D34FB1781B1BE4BB76E4
            A56C47686C16DA6B2FEEDEC72F7E762B9F878493F5B0E66CC1AFB71D389FE883
            90FD82B9EE57A5B604879BD55F9419E72CEDF986BA761576F93A639D3D034969
            79AA9E96DB7EC1BC8BE20B8208B737DD63A86D1BC22E3F1636AEA483977C4EA1
            EC78E849B86F8D4B0D0808280A0DF484CB9A95E8960FA2EA49139E891E9F1851
            486EB083D2B86CB6C7CD3D81DE705DBB0A1F640328ABA84363A3385EAD109799
            DA68E3E2C94D60582D4F328270D3CE6814533F876F8EF6359552310D85F94636
            2F0A348B549D41EFA125A73AC9E9B12B6AB9B89C8A91C4FCEC2FA2B032259B7A
            4B31453133EF0562FEDC047DDE235A8AB93F83B460372E54E03744075241E185
            01E60000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object PicDivTaxa: TfrxPictureView
          Left = 7.559055120000000000
          Top = 2.267716535433067000
          Width = 16.000000000000000000
          Height = 16.000000000000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          AutoSize = True
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF6100000030744558745469746C6500436C6561723B
            45726173653B52656D6F76653B426172733B526962626F6E3B466F726D617474
            696E673B9B846D960000033B4944415478DA85536948545114FEEE9B3582166D
            D11F19D8E2123559D8422A9695962D588109F9A341B445D24C4BA4ACCCA56835
            3333CDD268DFB346D046AD6462D4A406AD2449DB46B3B2DCA7F79C77BB6F3452
            FAD1E19DC779F7DCEF3BE79DFB5D72A9D0544608E70B669452D0FEC0168BD207
            951E165BADE5DA75B3FDD8BA884146F26ED6D08D6B3DF03FCBB9568DF0F59E0A
            46D0378420FB6A250D0FF644C19D6ADC29AE45D0D2E9085ED14F38D00F08F373
            D7ABB075C3FC7F09320A0C3432743E82A3F3713C2108DB93EF21FF7008F4867A
            645E2CC7AD3311EC7708722E3F43B4D65BF92E2E42686F7ADF5F4014418EE63E
            A1DBB5DEAC832ADCD4BDC4BA651AD88D5623F34229A2B48BE1336FAA6D0E8525
            750859EDA1663841C21A57F9D13E89E0605629DD19E10BC14AA1947378585A8B
            13E71F2186817D17B842E81321E73854BD68C288FCA454B54C96F0F16D43B27F
            71C57E46642507324A68C2163F74F50AD057BC462603C76E0A804A294772FA7D
            6C0BF3C7622F5798CEE5C149D60EFB591ABC2B298749579216F2AC662F493CAA
            A37BA202D0D9C3638D361D3BB72E87CF5C17AC0DCB40417A188ACA4D58C03742
            F1B50963DC5C40855E700A15DE54BF82E1F28D43243EED3E4D8A0D4447370FFB
            916AD6090F0B2FC2607C83D6EF3FE1DAFC020EFC378C739B0CF016DBB92826BB
            A321E5241A5ACC203149B7696AFC2A7474F1B624612FB99CB0790095BA32389A
            F418E7EACCC0BF6C0253B86B509F7804AD5D9DA8FDD2729C8446E6EA394EB688
            0E28D16D8A03264DB4439DB91BF2B1E3B1446986F3FB4A102606E58C59A8DF97
            8E4F3FDB50D3FCF9544AB3395ED28892B96C9036942B63AFA44D9BE9B6D9D979
            3C04265CF70F4668EC81FAE4D3686C6B85C1FCE1F4A91F6DBBD8DE1E2255FD63
            41BB75B89B1238CC3FE6764FC0EAB910C5FE9CC368198C793A78149DC06373E3
            D90BDD5DB16CB93B44A1128710B8AF3C86D70F76A89CBCE20E792EF48A9AED3D
            138EA364C8C87A0A4B67078619B2739F9B6B247067C5BCA5E241A31E43089C7C
            12F1F1E9018E85C31DE744A7DA4D708914781E8245406F7B4B6E4BE5913896EB
            584638D61CBBA1B6A10F2218AB8982D52AE0475D9644A262AE1E988FB4D72279
            0038D18ABF98DF7CF77C0FB3E7474B0000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object PicDivValorBruto: TfrxPictureView
          Left = 7.559055120000000000
          Top = 2.267716535433067000
          Width = 16.000000000000000000
          Height = 16.000000000000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          AutoSize = True
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF610000000F744558745469746C6500416E616C7973
            69733BC35957A3000000DA4944415478DA63FCFFFF3F033E50BE62862F90DA04
            E5FA01F16610A33322032CC088CF0034CD0CC886E03500A81144C13503153342
            C5FFA31B82CB00149BB11800360428BE199701F80306C960620DE88449116B00
            32370D886741D91DC886800DF06DDA81D3B99AAAF719A1CC50207E0FC47B80F8
            0C101BA318B0A9D61D43B35FF34E64038CA186607A0166C0A14387E012767676
            C806809C5D01957201E2DD580DC0E382FFD040DC03C533A1E142B40B60012908
            3508BB01785C801C0B695003708701C8761C5EC09E0E880C03AC80603A001ACC
            C84000000067AB99E112E0FA560000000049454E44AE426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object PicNConfirmado: TfrxPictureView
          Left = 7.559055120000000000
          Top = 2.267716535433067000
          Width = 16.000000000000000000
          Height = 16.000000000000000000
          Visible = False
          OnBeforePrint = 'picNotOnBeforePrint'
          AutoSize = True
          Picture.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000001000
            00001008060000001FF3FF61000000017352474200AECE1CE90000000467414D
            410000B18F0BFC610500000023744558745469746C650043616E63656C3B5374
            6F703B457869743B426172733B526962626F6E3B4C9696B2000003B349444154
            78DA1D936D50545518C7FFE7DEBDF772F785DD651728165840C3A2124644370D
            D360740AA9709C62AA69B4102B89AC71AAE94B9FFCC44CF9C68C9642E38C0E4E
            E208CC34161896689A4D4CA2622EB8ECB240E4C2DD5DD897BBF7DEBDDDBBE7CC
            9C73E6799EFF739EF33BE790A5A11F00DA004253306F7A951EF9604F45AEC9D8
            CAD074AD81A29E81D6E474FA4E5292AFF9C3E1EF5EEA3A7D4733294B43E75555
            5140B4052CF53B896634DC6EFFF080C562FECA545AC831395618EC56E80E4988
            22254490F005C590103EB8B6F34487664E457F3A97D6FDA4DDB3DEB4776DF545
            8B2BAFCEBE6E35D2620CAA98423A9504542D806141580E346F44F8AF718403B3
            BF7D3978F9B5817F1E44323BFFD9F2DE514749C1FB396B9E84EF971BB8D57B05
            C5552B51DD549B4930DA3782A9512F6A9A36A164CB7A84C71EE2DF497F8FE754
            F76E727147534D597EFEEFAEBA75B4FFEA1F181B5F846BFF6708F55F4076E036
            082188143D0B676313660E77E0E9553694D5D6207875347DCBFBF04532B4BDF1
            78E973957B4D0E13060E9E46DDE521589C7608910446BF39A63344E5276DB05A
            38C4162218AEAFC7F6CFDF427C218E0737FEEE2583DB5E9E70975857D01C8549
            DF326CCF6F46C5476DD0A863211CCF1CC16E33228BA171FF5827849161AC28E2
            A14880DF1F0D904B9BB7A6DCF92A9316E360AC764C0613B06D7D0565ADAD9A58
            85AA53D2584F7E7B02D1C17E94BA38C8421860594C2FB212E9F3BC9072DB120C
            4D1150061ABED924988666ACD6AA50F5AE2501288C1D390AF9C773703FC64295
            958C7D2A6A92C8D92ACFD413398A9B35A808CE2791DCB213E5FBF6C16EE5C167
            D1D04B8825658D491CDECE4EF0C3E7E1CA6321C92ABC02374B8E975775AFCCE5
            76393911777D716CBB7E1D49030F234763BAFB640662E1AE162D89045E11F1F3
            C60DA828CE8220B1B8F748EA23070ACA6A2BADD62B4F39242AC59A9170ADC2C6
            435FE3DEC92E3CBAD0A3BF33E4EE7803152DEFE2DAFE4FC107EF83139731BEC8
            E0A6106ED011F11DAEF22EB7D9D05C5EC0200116C19928EC7623F21D9CAEC77C
            488420C45158900D1E2226E6244C44E5FE2FE6BC6FEB09A80ACEE8D86D7DFC92
            CB4CAD29776581CB366BCF5882BC1C837E8FB4C90483465D8C2EC33B97C4D492
            32762632DF3026C666C9F4C76FA2E8F059BA9A35E735F2F6430ED6F0BACB46E0
            3451E01992F94C0949452896C64C58C57F923CD01B0BB5DD9512B381F6669968
            430654F1911E4A9B8CEF189D1B0A29768F91A23C0C48A15E81A69F89A9E99B01
            45FCFE4C62E1572D2EA6E9145DF73F2B91898E5FE860A30000000049454E44AE
            426082}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 122.385900000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        object Memo15: TfrxMemoView
          Align = baRight
          Left = 642.520148819999900000
          Top = 48.763760000000020000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBExtratoCartoes."EXT_VALBRU">,MasterDataExtratoCartoes' +
              ')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 642.520148819999900000
          Top = 68.440939999999990000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBExtratoCartoes."EXT_VALLIQ">,MasterDataExtratoCartoes' +
              ')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Top = 23.999999999999970000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Align = baRight
          Left = 642.520100000000000000
          Top = 87.354360000000010000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterDataExtratoCartoes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 21.559060000000020000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo24: TfrxMemoView
          Align = baRight
          Left = 510.236598819999900000
          Top = 48.787401574803110000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor s/ Taxa:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 510.236598819999900000
          Top = 66.456710000000010000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor L'#237'quido:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 510.236549999999900000
          Top = 87.535433069999990000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 40.795300000000030000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 64.472480000000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 642.520148819999900000
          Top = 10.763759999999990000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBExtratoCartoes."EXT_VALLIQ">,MasterDataExtratoCartoes' +
              ')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 566.929597639999900000
          Top = 10.543290000000010000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBExtratoCartoes."EXT_VALTAX">,MasterDataExtratoCartoes' +
              ')]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Top = 10.000000000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total por p'#225'gina')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 28.795300000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 7.559059999999988000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 44.574830000000020000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'frmConfirmacaoDeCartoes')
          ParentFont = False
          VAlign = vaBottom
        end
        object Page: TfrxMemoView
          Left = 680.315400000000000000
          Top = 49.133890000000010000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Align = baRight
          Left = 491.339046459999900000
          Top = 11.338590000000010000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllLiqTipOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDBExtratoCartoes."EXT_VALBRU">,MasterDataExtratoCartoes' +
              ')]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxDBExtratoCartoes: TfrxDBDataset
    UserName = 'frxDBExtratoCartoes'
    CloseDataSource = False
    DataSet = UniClientDataSetExtrato
    BCDToCurrency = False
    Left = 112
    Top = 36
  end
  object UniClientDataSetExtrato: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 36
    object UniClientDataSetExtratoEXT_NUM_PV: TStringField
      FieldName = 'EXT_NUM_PV'
      Size = 15
    end
    object UniClientDataSetExtratoEXT_CODAUT: TStringField
      FieldName = 'EXT_CODAUT'
      Size = 40
    end
    object UniClientDataSetExtratoEXT_NUMNSU: TStringField
      FieldName = 'EXT_NUMNSU'
      Size = 40
    end
    object UniClientDataSetExtratoEXT_PARCEL: TStringField
      FieldName = 'EXT_PARCEL'
      Size = 3
    end
    object UniClientDataSetExtratoEXT_DTACUP: TDateField
      FieldName = 'EXT_DTACUP'
    end
    object UniClientDataSetExtratoEXT_DTAVEN: TDateField
      FieldName = 'EXT_DTAVEN'
    end
    object UniClientDataSetExtratoEXT_VALBRU: TFloatField
      FieldName = 'EXT_VALBRU'
    end
    object UniClientDataSetExtratoEXT_VALTAX: TFloatField
      FieldName = 'EXT_VALTAX'
    end
    object UniClientDataSetExtratoEXT_VALLIQ: TFloatField
      FieldName = 'EXT_VALLIQ'
    end
    object UniClientDataSetExtratoEXT_NOMCON: TStringField
      FieldName = 'EXT_NOMCON'
      Size = 50
    end
    object UniClientDataSetExtratoEXT_STATUS: TStringField
      FieldName = 'EXT_STATUS'
    end
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 296
    Top = 36
  end
end
