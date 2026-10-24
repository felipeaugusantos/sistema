unit untQckHTMLCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxExportMail, frxExportHTML, frxDesgn, DB, Uni, frxDBSet,
  UniClientDataSet, frxExportPDF, UniDataSetProvider, MemDS, DBAccess,
  Datasnap.DBClient, DateUtils;

type
  TfrmQckHTMLCliente = class(TForm)
    frxRetrato: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    qryRelatorio: TUniQuery;
    qryCliente: TUniQuery;
    frxCliente: TfrxDBDataset;
    frxEmpresa: TfrxDBDataset;
    qryEmpresa: TUniQuery;
    qryClienteNOME: TStringField;
    qryClienteFANTASIA: TStringField;
    qryClienteENDERECO: TStringField;
    qryClienteBAIRRO: TStringField;
    qryClienteTELEFONE: TStringField;
    qryClienteCLI_CGCCPF: TLongWordField;
    qryClienteCLI_C_G_C_: TStringField;
    qryClienteCLI_F_A_X_: TStringField;
    qryClienteCLI_I_E_S_: TStringField;
    qryClienteCONTATO: TStringField;
    qryEmpresaEMPRESA: TStringField;
    qryEmpresaENDERECO: TStringField;
    qryEmpresaBAIRRO: TStringField;
    qryEmpresaCIDADE: TStringField;
    qryEmpresaCEP: TStringField;
    qryEmpresaEMP_F_A_X_: TStringField;
    qryEmpresaEMP_CONTAT: TStringField;
    qryEmpresaEMP_EMAIL_: TStringField;
    qryEmpresaDATA: TDateField;
    frxTotal: TfrxDBDataset;
    qryInformacoes: TUniClientDataSet;
    frxInformacoes: TfrxDBDataset;
    frxExportaPDF: TfrxPDFExport;
    frxCheque: TfrxDBDataset;
    qryInformacoesCHEQUE: TStringField;
    qryInformacoesIMAGEM: TStringField;
    qryInformacoesDIRETORIO: TStringField;
    qryClienteTELEFONE2: TStringField;
    cdsTotal: TUniClientDataSet;
    cdsTotalDUPVEN: TFloatField;
    cdsTotalDUPAVE: TFloatField;
    cdsTotalTOTALCORRIGIDO: TFloatField;
    cdsTotalTOTALDIFERENCA: TFloatField;
    cdsTotalTOTALJUROS: TFloatField;
    cdsTotalTOTALRECEBIDO: TFloatField;
    cdsTotalTOTALDUPLICATA: TFloatField;
    cdsCheque: TUniClientDataSet;
    qryInformacoesADICIONAIS: TMemoField;
    qryEmpresaTELEFONE1: TStringField;
    qryEmpresaTELEFONE2: TStringField;
    qryFeriado: TUniQuery;
    cdsTotalTOTALDUP: TFloatField;
    qryClienteREDE: TStringField;
    qryClienteEMAIL: TStringField;
    frxPaisagem: TfrxReport;
    cdsTotalTOTALCREDITODISP: TFloatField;
    cdsTotalCREDCLI: TFloatField;
    procedure FormCreate(Sender: TObject);
    function frxRetratoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxPaisagemUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    blnDtaVencimento : Boolean;
    { Private declarations }
    function fFormataFonePaisInterna(strTelefo: String): String;
    function fDiasAtraso(dias, dataVencimento, dataRecebimento:String;tipo:Integer) : String;
  public
    { Public declarations }
    procedure setDtaVencimento(setup:Boolean);
  end;


implementation

uses untFuncoesGenerica, untModulo;

{$R *.dfm}

function TfrmQckHTMLCliente.fDiasAtraso(dias, dataVencimento, dataRecebimento:String;tipo:Integer): String;
  function fBuscaProxDiaUtil(data:TDateTime):TDateTime;
    function fExisteFeriado(data:TDateTime):Boolean;
    begin
      qryFeriado.Close;
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
    end;
  Var
    dataNova : TDateTime;
  begin
    dataNova := data;

    if DayOfWeek(dataNova) = 1 then
      dataNova := datanova + 1;

    if DayOfWeek(dataNova) = 7 then
      dataNova := datanova + 2;

    while (fExisteFeriado(dataNova)) or (dayOfWeek(dataNova) in [1,7]) do
      dataNova := datanova + 1;

    result := dataNova;
  end;


  Var
    dtaDtaVen: TDateTime;
    dtaDtaCalculo: TDateTime;
    dtaDtaAnt: TDateTime;
    dtaDtaRec: TDateTime;
    intAtraso: Double;
    intDiasAtraso: Integer;
Begin
  Try

      if not blnDtaVencimento then
      begin
        Case tipo of
          1: Result := dias;
          2: Result := FormatDateTime('DD/MM/YY', StrToDate(dataVencimento));
        end;
      end
      else
      begin
        {************************************************}
        {* CASO TENHA SIDO NECESSARIA ALTERACAO NA DATA *}
        {*********************************************FA*}

        dtaDtaAnt := StrToDateTime(dataVencimento);  // data de vencimento (data base)
        dtaDtaRec := StrToDateTime(dataRecebimento); // data de recebimento do titulo

        dtaDtaVen := fBuscaProxDiaUtil(dtaDtaAnt); // calcula a real data de vencimento

        If (dtaDtaVen <> dtaDtaAnt) Then
        begin
          if dtaDtaRec <> 0 then
          begin
            if dtaDtaRec <= dtaDtaVen then
              intAtraso := 0
            else
              intAtraso := dtaDtaRec - dtaDtaVen;
          end
          else
          begin
            intAtraso := Date - dtaDtaVen;
          end;
        end
        else
        begin
          dtaDtaCalculo := dtaDtaVen;

          if dtaDtaRec <> 0 then
          begin
            if dtaDtaRec <= dtaDtaCalculo then
            begin
              intDiasAtraso := 0;
            end
            else
            begin
              intDiasAtraso := DaysBetween(dtaDtaRec,dtaDtaCalculo);
            end;
          end
          else
          begin
            if dtaDtaCalculo >= Date then
              intDiasAtraso := 0
            else
              intDiasAtraso := DaysBetween(Date,dtaDtaCalculo);
          end;
          intAtraso := intDiasAtraso;
        end;

        Case tipo of
          1 : result := FloatToStr(intAtraso);
          2 : result := FormatDateTime('DD/MM/YY', dtaDtaVen);
        end;

      end;

      if tipo = 1 then
        if StrToInt(result) < 0 then
          result := '0';

  Except
    On E : Exception Do
    Begin
        Case tipo of
          1: Result := dias;
          2: Result := FormatDateTime('DD/MM/YY', StrToDate(dataVencimento));
        end;
    End;
  End;
end;

function TfrmQckHTMLCliente.fFormataFonePaisInterna(strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

procedure TfrmQckHTMLCliente.FormCreate(Sender: TObject);
begin
  qryEmpresa.Connection   := frmModulo.GetCurrentConnection;
  qryCliente.Connection   := frmModulo.GetCurrentConnection;
  qryRelatorio.Connection := frmModulo.GetCurrentConnection;
  qryFeriado.Connection   := frmModulo.GetCurrentConnection;

  frxRetrato.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxRetrato.AddFunction('function fDiasAtraso(dias, dataVencimento, dataRecebimento:String;tipo:Integer): String;');

  frxPaisagem.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxPaisagem.AddFunction('function fDiasAtraso(dias, dataVencimento, dataRecebimento:String;tipo:Integer): String;');

end;

function TfrmQckHTMLCliente.frxPaisagemUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);
  if SameText(MethodName, 'fDiasAtraso') then
    result := fDiasAtraso(Params[0], Params[1], Params[2], Params[3]);

end;

function TfrmQckHTMLCliente.frxRetratoUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);
  if SameText(MethodName, 'fDiasAtraso') then
    result := fDiasAtraso(Params[0], Params[1], Params[2], Params[3]);
end;

procedure TfrmQckHTMLCliente.setDtaVencimento(setup: Boolean);
begin
  blnDtaVencimento := setup;
end;

end.
